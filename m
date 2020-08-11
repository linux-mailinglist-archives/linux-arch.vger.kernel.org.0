Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577EE241FC6
	for <lists+linux-arch@lfdr.de>; Tue, 11 Aug 2020 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgHKSf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Aug 2020 14:35:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:37295 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbgHKSf1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 14:35:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597170927; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=HLfx66Qfv2Fz/O1/H/r9cB91ctPu5jWiwIdXdnUxrZ8=; b=AuEf7/08/pQCsprI3beHNCS+QsYPMS6YdWsyB0wHYbjwIUUqbfEox6n5wZtoa5gApSMA9A9X
 IqoLNX8fu4GyiRqtpBVa6hEFUCIB130LMode/WxNQHGdQMT7Mghe+gnVX+K1X6wAAgW8sv6P
 8KujHBTPDqbrOOlfTpIXhkw1PAM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5MDNlZiIsICJsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f32e4ee856720175157cf0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 18:35:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20066C433CB; Tue, 11 Aug 2020 18:35:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1525C433C9;
        Tue, 11 Aug 2020 18:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1525C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Al Viro'" <viro@ZenIV.linux.org.uk>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'David Miller'" <davem@davemloft.net>,
        "'Tony Luck'" <tony.luck@intel.com>,
        "'Will Deacon'" <will@kernel.org>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk> <20200629182628.529995-1-viro@ZenIV.linux.org.uk> <20200629182628.529995-33-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200629182628.529995-33-viro@ZenIV.linux.org.uk>
Subject: RE: [PATCH 33/41] hexagon: switch to ->get2()
Date:   Tue, 11 Aug 2020 13:35:23 -0500
Message-ID: <038001d6700e$2da6af80$88f40e80$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEanwUtOMewLvTwAuMraiGO5PXRUAF01hBRAYLg5auqkyCGQA==
Content-Language: en-us
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> -----Original Message-----
> From: linux-arch-owner@vger.kernel.org <linux-arch-owner@vger.kernel.org>
> On Behalf Of Al Viro

Acked-by: Brian Cain <bcain@codeaurora.org>

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/hexagon/kernel/ptrace.c | 62
+++++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
index
> dcbf7ea960cc..fa6287d1a061 100644
> --- a/arch/hexagon/kernel/ptrace.c
> +++ b/arch/hexagon/kernel/ptrace.c
> @@ -35,58 +35,38 @@ void user_disable_single_step(struct task_struct
*child)
> 
>  static int genregs_get(struct task_struct *target,
>  		   const struct user_regset *regset,
> -		   unsigned int pos, unsigned int count,
> -		   void *kbuf, void __user *ubuf)
> +		   srtuct membuf to)
>  {
> -	int ret;
> -	unsigned int dummy;
>  	struct pt_regs *regs = task_pt_regs(target);
> 
> -
> -	if (!regs)
> -		return -EIO;
> -
>  	/* The general idea here is that the copyout must happen in
>  	 * exactly the same order in which the userspace expects these
>  	 * regs. Now, the sequence in userspace does not match the
>  	 * sequence in the kernel, so everything past the 32 gprs
>  	 * happens one at a time.
>  	 */
> -	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -				  &regs->r00, 0, 32*sizeof(unsigned long));
> -
> -#define ONEXT(KPT_REG, USR_REG) \
> -	if (!ret) \
> -		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, \
> -			KPT_REG, offsetof(struct user_regs_struct, USR_REG),
> \
> -			offsetof(struct user_regs_struct, USR_REG) + \
> -				 sizeof(unsigned long));
> -
> +	membuf_write(&to, &regs->r00, 32*sizeof(unsigned long));
>  	/* Must be exactly same sequence as struct user_regs_struct */
> -	ONEXT(&regs->sa0, sa0);
> -	ONEXT(&regs->lc0, lc0);
> -	ONEXT(&regs->sa1, sa1);
> -	ONEXT(&regs->lc1, lc1);
> -	ONEXT(&regs->m0, m0);
> -	ONEXT(&regs->m1, m1);
> -	ONEXT(&regs->usr, usr);
> -	ONEXT(&regs->preds, p3_0);
> -	ONEXT(&regs->gp, gp);
> -	ONEXT(&regs->ugp, ugp);
> -	ONEXT(&pt_elr(regs), pc);
> -	dummy = pt_cause(regs);
> -	ONEXT(&dummy, cause);
> -	ONEXT(&pt_badva(regs), badva);
> +	membuf_store(&to, regs->sa0);
> +	membuf_store(&to, regs->lc0);
> +	membuf_store(&to, regs->sa1);
> +	membuf_store(&to, regs->lc1);
> +	membuf_store(&to, regs->m0);
> +	membuf_store(&to, regs->m1);
> +	membuf_store(&to, regs->usr);
> +	membuf_store(&to, regs->p3_0);
> +	membuf_store(&to, regs->gp);
> +	membuf_store(&to, regs->ugp);
> +	membuf_store(&to, pt_elr(regs)); // pc
> +	membuf_store(&to, (unsigned long)pt_cause(regs)); // cause
> +	membuf_store(&to, pt_badva(regs)); // badva
>  #if CONFIG_HEXAGON_ARCH_VERSION >=4
> -	ONEXT(&regs->cs0, cs0);
> -	ONEXT(&regs->cs1, cs1);
> +	membuf_store(&to, regs->cs0);
> +	membuf_store(&to, regs->cs1);
> +	return membuf_zero(&to, sizeof(unsigned long)); #else
> +	return membuf_zero(&to, 3 * sizeof(unsigned long));
>  #endif
> -
> -	/* Pad the rest with zeros, if needed */
> -	if (!ret)
> -		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
> -					offsetof(struct user_regs_struct,
> pad1), -1);
> -	return ret;
>  }
> 
>  static int genregs_set(struct task_struct *target, @@ -159,7 +139,7 @@
static
> const struct user_regset hexagon_regsets[] = {
>  		.n = ELF_NGREG,
>  		.size = sizeof(unsigned long),
>  		.align = sizeof(unsigned long),
> -		.get = genregs_get,
> +		.get2 = genregs_get,
>  		.set = genregs_set,
>  	},
>  };
> --
> 2.11.0


