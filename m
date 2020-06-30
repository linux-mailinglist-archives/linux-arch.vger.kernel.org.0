Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671F120F577
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgF3NQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jun 2020 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgF3NQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2020 09:16:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7FC061755;
        Tue, 30 Jun 2020 06:16:49 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqG7s-002o2d-Hl; Tue, 30 Jun 2020 13:16:40 +0000
Date:   Tue, 30 Jun 2020 14:16:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 22/41] sparc: switch to ->get2()
Message-ID: <20200630131640.GE2786714@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
 <20200629182628.529995-22-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629182628.529995-22-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 07:26:09PM +0100, Al Viro wrote:
  
>  static int getregs64_get(struct task_struct *target,
>  			 const struct user_regset *regset,
> -			 unsigned int pos, unsigned int count,
> -			 void *kbuf, void __user *ubuf)
> +			 struct membuf to)
>  {
>  	const struct pt_regs *regs = task_pt_regs(target);
> -	int ret;
>  
>  	if (target == current)
>  		flushw_user();
>  
> -	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -				  regs->u_regs + 1,
> -				  0, 15 * sizeof(u64));
> -	if (!ret)
> -		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
> -				  15 * sizeof(u64), 16 * sizeof(u64));
> -	if (!ret) {
> -		/* TSTATE, TPC, TNPC */
> -		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					  &regs->tstate,
> -					  16 * sizeof(u64),
> -					  19 * sizeof(u64));
> -	}
> -	if (!ret) {
> -		unsigned long y = regs->y;
> -
> -		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					  &y,
> -					  19 * sizeof(u64),
> -					  20 * sizeof(u64));
> -	}
> -	return ret;
> +	membuf_write(&to, regs->u_regs + 1, 15 * sizeof(u64));
> +	return membuf_store(&to, (u64)0);
	^^^^^^
Er...  That should be simply

+	membuf_store(&to, (u64)0);

> +	membuf_write(&to, &regs->tstate, 3 * sizeof(u64));
> +	return membuf_store(&to, (u64)regs->y);
>  }
