Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89D6C4CE4
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCVOFj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCVOFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 10:05:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DADE65328E;
        Wed, 22 Mar 2023 07:05:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908FA4B3;
        Wed, 22 Mar 2023 07:06:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79C13F71E;
        Wed, 22 Mar 2023 07:05:15 -0700 (PDT)
Date:   Wed, 22 Mar 2023 14:05:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [PATCH v2 1/4] lib: test copy_{to,from}_user()
Message-ID: <ZBsLGTYjKoUTLrva@FVFF77S0Q05N>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-2-mark.rutland@arm.com>
 <ZBnk3O0QLs6+8KNN@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnk3O0QLs6+8KNN@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 05:09:48PM +0000, Catalin Marinas wrote:
> On Tue, Mar 21, 2023 at 12:25:11PM +0000, Mark Rutland wrote:
> > +static void assert_size_valid(struct kunit *test,
> > +			      const struct usercopy_params *params,
> > +			      unsigned long ret)
> > +{
> > +	const unsigned long size = params->size;
> > +	const unsigned long offset = params->offset;
> 
> I think you should drop the 'unsigned' for 'offset', it better matches
> the usercopy_params structure and the 'offset < 0' test.

Agreed. I'll go fix all offset values to use long.

[...]

> > +	if (ret < (offset + size) - PAGE_SIZE) {
> > +		KUNIT_ASSERT_FAILURE(test,
> > +			   "too many bytes consumed (offset=%ld, size=%lu, ret=%lu)",
> > +			   offset, size, ret);
> > +	}
> > +}
> 
> Nitpick: slightly less indentation probably if we write the above as:
> 
> 	KUNIT_ASSERT_TRUE_MSG(test,
> 		ret < (offset + size) - PAGE_SIZE,
> 		"too many bytes consumed (offset=%ld, size=%lu, ret=%lu)",
> 		offset, size, ret);
> 
> Not sure this works for the early return cases above.

I had originally used KUNIT_ASSERT_*_MSG(), but found those produced a lot of
unhelpful output; lemme go check what KUNIT_ASSERT_TRUE_MSG() produces.

[...]

> > +	/*
> > +	 * A usercopy MUST NOT modify any bytes before the destination buffer.
> > +	 */
> > +	for (int i = 0; i < dst_offset; i++) {
> > +		char val = dst[i];
> > +
> > +		if (val == 0)
> > +			continue;
> > +
> > +		KUNIT_ASSERT_FAILURE(test,
> > +			"pre-destination bytes modified (dst_page[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
> > +			i, val, offset, size, ret);
> > +	}
> > +
> > +	/*
> > +	 * A usercopy MUST NOT modify any bytes after the end of the destination
> > +	 * buffer.
> > +	 */
> 
> Without looking at the arm64 fixes in this series, I think such test can
> fail for us currently given the right offset.

Yes, it can.

The test matches the documened semantic, so in that sense it's correctly
detecting that arm64 doesn't match the documentation.

Whether the documentation is right is clearly the key issue here. :)

> > +/*
> > + * Generate the size and offset combinations to test.
> > + *
> > + * Usercopies may have different paths for small/medium/large copies, but
> > + * typically max out at 64 byte chunks. We test sizes 0 to 128 bytes to check
> > + * all combinations of leading/trailing chunks and bulk copies.
> > + *
> > + * For each size, we test every offset relative to a leading and trailing page
> > + * boundary (i.e. [size, 0] and [PAGE_SIZE - size, PAGE_SIZE]) to check every
> > + * possible faulting boundary.
> > + */
> > +#define for_each_size_offset(size, offset)				\
> > +	for (unsigned long size = 0; size <= 128; size++)		\
> > +		for (long offset = -size;				\
> > +		     offset <= (long)PAGE_SIZE;				\
> > +		     offset = (offset ? offset + 1: (PAGE_SIZE - size)))
> > +
> > +static void test_copy_to_user(struct kunit *test)
> > +{
> > +	const struct usercopy_env *env = test->priv;
> > +
> > +	for_each_size_offset(size, offset) {
> > +		const struct usercopy_params params = {
> > +			.size = size,
> > +			.offset = offset,
> > +		};
> > +		unsigned long ret;
> > +
> > +		buf_init_zero(env->ubuf);
> > +		buf_init_pattern(env->kbuf);
> > +
> > +		ret = do_copy_to_user(env, &params);
> > +
> > +		assert_size_valid(test, &params, ret);
> > +		assert_src_valid(test, &params, env->kbuf, 0, ret);
> > +		assert_dst_valid(test, &params, env->ubuf, params.offset, ret);
> > +		assert_copy_valid(test, &params,
> > +				  env->ubuf, params.offset,
> > +				  env->kbuf, 0,
> > +				  ret);
> > +	}
> > +}
> 
> IIUC, in such tests you only vary the destination offset. Our copy
> routines in general try to align the source and leave the destination
> unaligned for performance. It would be interesting to add some variation
> on the source offset as well to spot potential issues with that part of
> the memcpy routines.

I have that on my TODO list; I had intended to drop that into the
usercopy_params. The only problem is that the cross product of size,
src_offset, and dst_offset gets quite large.

Thanks,
Mark.
