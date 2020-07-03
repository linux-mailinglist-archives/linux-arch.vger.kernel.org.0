Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4342138F5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCKvF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 06:51:05 -0400
Received: from foss.arm.com ([217.140.110.172]:48998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGCKvC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 06:51:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCF071045;
        Fri,  3 Jul 2020 03:51:01 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEB8F3F68F;
        Fri,  3 Jul 2020 03:50:59 -0700 (PDT)
Date:   Fri, 3 Jul 2020 11:50:49 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: Re: [PATCH v5 19/25] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Message-ID: <20200703104412.GB14950@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-20-catalin.marinas@arm.com>
 <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Luis,

On Thu, Jun 25, 2020 at 02:10:10PM -0300, Luis Machado wrote:
> On 6/24/20 2:52 PM, Catalin Marinas wrote:
> > +/*
> > + * Access MTE tags in another process' address space as given in mm. Update
> > + * the number of tags copied. Return 0 if any tags copied, error otherwise.
> > + * Inspired by __access_remote_vm().
> > + */
> > +static int __access_remote_tags(struct task_struct *tsk, struct mm_struct *mm,
> > +				unsigned long addr, struct iovec *kiov,
> > +				unsigned int gup_flags)
> > +{
> > +	struct vm_area_struct *vma;
> > +	void __user *buf = kiov->iov_base;
> > +	size_t len = kiov->iov_len;
> > +	int ret;
> > +	int write = gup_flags & FOLL_WRITE;
> > +
> > +	if (!access_ok(buf, len))
> > +		return -EFAULT;
> > +
> > +	if (mmap_read_lock_killable(mm))
> > +		return -EIO;
> > +
> > +	while (len) {
> > +		unsigned long tags, offset;
> > +		void *maddr;
> > +		struct page *page = NULL;
> > +
> > +		ret = get_user_pages_remote(tsk, mm, addr, 1, gup_flags,
> > +					    &page, &vma, NULL);
> > +		if (ret <= 0)
> > +			break;
> > +
> > +		/*
> > +		 * Only copy tags if the page has been mapped as PROT_MTE
> > +		 * (PG_mte_tagged set). Otherwise the tags are not valid and
> > +		 * not accessible to user. Moreover, an mprotect(PROT_MTE)
> > +		 * would cause the existing tags to be cleared if the page
> > +		 * was never mapped with PROT_MTE.
> > +		 */
> > +		if (!test_bit(PG_mte_tagged, &page->flags)) {
> > +			ret = -EOPNOTSUPP;
> > +			put_page(page);
> > +			break;
> > +		}
[...]
> My understanding is that both the PEEKMTETAGS and POKEMTETAGS can
> potentially read/write less tags than requested, right? The iov_len field
> will be updated accordingly.

Yes.

(I missed this part due to the mix of top/bottom-posting)

> So the ptrace caller would need to loop and make sure all the tags were
> read/written, right?

Yes. As per the documentation patch, if the ptrace call returns 0,
iov_len is updated to the number of tags copied. The caller can retry
until it gets a negative return (error) or everything was copied.

> I'm considering the situation where the kernel reads/writes 0 tags (when
> requested to read/write 1 or more tags) an error we can't recover from. So
> this may indicate a page without PROT_MTE or an invalid address.

For this case, it should return -EOPNOTSUPP (see the documentation
patch; and, of course, also test the syscall in case I got anything
wrong).

-- 
Catalin
