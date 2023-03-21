Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2546C37D9
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCURKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCURKu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 13:10:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B753727;
        Tue, 21 Mar 2023 10:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD9B7B818F2;
        Tue, 21 Mar 2023 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19616C433D2;
        Tue, 21 Mar 2023 17:09:50 +0000 (UTC)
Date:   Tue, 21 Mar 2023 17:09:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, agordeev@linux.ibm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [PATCH v2 1/4] lib: test copy_{to,from}_user()
Message-ID: <ZBnk3O0QLs6+8KNN@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
 <20230321122514.1743889-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321122514.1743889-2-mark.rutland@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 12:25:11PM +0000, Mark Rutland wrote:
> +static void assert_size_valid(struct kunit *test,
> +			      const struct usercopy_params *params,
> +			      unsigned long ret)
> +{
> +	const unsigned long size = params->size;
> +	const unsigned long offset = params->offset;

I think you should drop the 'unsigned' for 'offset', it better matches
the usercopy_params structure and the 'offset < 0' test.

> +
> +	if (ret > size) {
> +		KUNIT_ASSERT_FAILURE(test,
> +			"return value is impossibly large (offset=%ld, size=%lu, ret=%lu)",
> +			offset, size, ret);
> +	}
> +
> +	/*
> +	 * When the user buffer starts within a faulting page, no bytes can be
> +	 * copied, so ret must equal size.
> +	 */
> +	if (offset < 0 || offset >= PAGE_SIZE) {
> +		if (ret == size)
> +			return;
> +
> +		KUNIT_ASSERT_FAILURE(test,
> +			"impossible copy did not fail (offset=%ld, size=%lu, ret=%lu)",
> +			offset, size, ret);
> +	}
> +
> +	/*
> +	 * When the user buffer fits entirely within a non-faulting page, all
> +	 * bytes must be copied, so ret must equal 0.
> +	 */
> +	if (offset + size <= PAGE_SIZE) {
> +		if (ret == 0)
> +			return;
> +
> +		KUNIT_ASSERT_FAILURE(test,
> +			"completely possible copy failed (offset=%ld, size=%lu, ret=%lu)",
> +			offset, size, ret);
> +	}
> +
> +	/*
> +	 * The buffer starts in a non-faulting page, but continues into a
> +	 * faulting page. At least one byte must be copied, and at most all the
> +	 * non-faulting bytes may be copied.
> +	 */
> +	if (ret == size) {
> +		KUNIT_ASSERT_FAILURE(test,
> +			"too few bytes consumed (offset=%ld, size=%lu, ret=%lu)",
> +			offset, size, ret);
> +	}
> +
> +	if (ret < (offset + size) - PAGE_SIZE) {
> +		KUNIT_ASSERT_FAILURE(test,
> +			   "too many bytes consumed (offset=%ld, size=%lu, ret=%lu)",
> +			   offset, size, ret);
> +	}
> +}

Nitpick: slightly less indentation probably if we write the above as:

	KUNIT_ASSERT_TRUE_MSG(test,
		ret < (offset + size) - PAGE_SIZE,
		"too many bytes consumed (offset=%ld, size=%lu, ret=%lu)",
		offset, size, ret);

Not sure this works for the early return cases above.

> +static void assert_src_valid(struct kunit *test,
> +			     const struct usercopy_params *params,
> +			     const char *src, long src_offset,
> +			     unsigned long ret)
> +{
> +	const unsigned long size = params->size;
> +	const unsigned long offset = params->offset;

The unsigned offset here doesn't matter much but I'd drop it as well.

> +	/*
> +	 * A usercopy MUST NOT modify the source buffer.
> +	 */
> +	for (int i = 0; i < PAGE_SIZE; i++) {
> +		char val = src[i];
> +
> +		if (val == buf_pattern(i))
> +			continue;
> +
> +		KUNIT_ASSERT_FAILURE(test,
> +			"source bytes modified (src[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
> +			i, offset, size, ret);
> +	}
> +}
> +
> +static void assert_dst_valid(struct kunit *test,
> +			     const struct usercopy_params *params,
> +			     const char *dst, long dst_offset,
> +			     unsigned long ret)
> +{
> +	const unsigned long size = params->size;
> +	const unsigned long offset = params->offset;
> +
> +	/*
> +	 * A usercopy MUST NOT modify any bytes before the destination buffer.
> +	 */
> +	for (int i = 0; i < dst_offset; i++) {
> +		char val = dst[i];
> +
> +		if (val == 0)
> +			continue;
> +
> +		KUNIT_ASSERT_FAILURE(test,
> +			"pre-destination bytes modified (dst_page[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
> +			i, val, offset, size, ret);
> +	}
> +
> +	/*
> +	 * A usercopy MUST NOT modify any bytes after the end of the destination
> +	 * buffer.
> +	 */

Without looking at the arm64 fixes in this series, I think such test can
fail for us currently given the right offset.

> +	for (int i = dst_offset + size - ret; i < PAGE_SIZE; i++) {
> +		char val = dst[i];
> +
> +		if (val == 0)
> +			continue;
> +
> +		KUNIT_ASSERT_FAILURE(test,
> +			"post-destination bytes modified (dst_page[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
> +			i, val, offset, size, ret);
> +	}
> +}

[...]

> +/*
> + * Generate the size and offset combinations to test.
> + *
> + * Usercopies may have different paths for small/medium/large copies, but
> + * typically max out at 64 byte chunks. We test sizes 0 to 128 bytes to check
> + * all combinations of leading/trailing chunks and bulk copies.
> + *
> + * For each size, we test every offset relative to a leading and trailing page
> + * boundary (i.e. [size, 0] and [PAGE_SIZE - size, PAGE_SIZE]) to check every
> + * possible faulting boundary.
> + */
> +#define for_each_size_offset(size, offset)				\
> +	for (unsigned long size = 0; size <= 128; size++)		\
> +		for (long offset = -size;				\
> +		     offset <= (long)PAGE_SIZE;				\
> +		     offset = (offset ? offset + 1: (PAGE_SIZE - size)))
> +
> +static void test_copy_to_user(struct kunit *test)
> +{
> +	const struct usercopy_env *env = test->priv;
> +
> +	for_each_size_offset(size, offset) {
> +		const struct usercopy_params params = {
> +			.size = size,
> +			.offset = offset,
> +		};
> +		unsigned long ret;
> +
> +		buf_init_zero(env->ubuf);
> +		buf_init_pattern(env->kbuf);
> +
> +		ret = do_copy_to_user(env, &params);
> +
> +		assert_size_valid(test, &params, ret);
> +		assert_src_valid(test, &params, env->kbuf, 0, ret);
> +		assert_dst_valid(test, &params, env->ubuf, params.offset, ret);
> +		assert_copy_valid(test, &params,
> +				  env->ubuf, params.offset,
> +				  env->kbuf, 0,
> +				  ret);
> +	}
> +}

IIUC, in such tests you only vary the destination offset. Our copy
routines in general try to align the source and leave the destination
unaligned for performance. It would be interesting to add some variation
on the source offset as well to spot potential issues with that part of
the memcpy routines.

-- 
Catalin
