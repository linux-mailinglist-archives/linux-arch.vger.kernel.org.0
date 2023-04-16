Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC06E3AE7
	for <lists+linux-arch@lfdr.de>; Sun, 16 Apr 2023 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDPR5G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Apr 2023 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPR5F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Apr 2023 13:57:05 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B31FD4;
        Sun, 16 Apr 2023 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1681667822; bh=Ycs3BbkcbYBxkaedeLz9oNKmeJ6DgMiMBUEi4pn/pqw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=n1XN50xgMfcNt1jP5AtB5DOaPLdUPz9LoGXVTTclyLrC3J7IlfV2aX6b/gj2Tuhob
         26xwHgieBJ3Xbsy0D7CjRoReRZqrKQYVaVi5D3Jlbw2Yk8ZsBjdYu3D0jSeWSDreV/
         CXJkBBCzaEExUdWty/Hzwopa0hqoMeCZR71ZUvVs=
Received: from [192.168.9.172] (unknown [101.228.138.124])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 1F8276011C;
        Mon, 17 Apr 2023 01:57:02 +0800 (CST)
Message-ID: <ab6e8eeb-576c-436b-abee-fd9bce08ac0c@xen0n.name>
Date:   Mon, 17 Apr 2023 01:57:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] LoongArch: Relay BCE exceptions to userland as
 SIGSEGVs with si_code=SEGV_BNDERR
From:   WANG Xuerui <kernel@xen0n.name>
To:     loongarch@lists.linux.dev
Cc:     WANG Xuerui <git@xen0n.name>, Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416173326.3995295-1-kernel@xen0n.name>
 <20230416173326.3995295-3-kernel@xen0n.name>
Content-Language: en-US
In-Reply-To: <20230416173326.3995295-3-kernel@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/17/23 01:33, WANG Xuerui wrote:
> <snip>
> @@ -589,6 +591,110 @@ static void bug_handler(struct pt_regs *regs)
>   	}
>   }
>   
> +asmlinkage void noinstr do_bce(struct pt_regs *regs)
> +{
> +	irqentry_state_t state = irqentry_enter(regs);
> +	bool user = user_mode(regs);
> +	unsigned long era = exception_era(regs);
> +	union loongarch_instruction insn;
> +	u64 badv = 0, lower = 0, upper = ULONG_MAX;
> +
> +	if (regs->csr_prmd & CSR_PRMD_PIE)
> +		local_irq_enable();
> +
> +	current->thread.trap_nr = read_csr_excode();
> +
> +	/*
> +	 * notify the kprobe handlers, if instruction is likely to
> +	 * pertain to them.
> +	 */
> +	if (notify_die(DIE_BOUNDS_CHECK, "Bounds check error", regs, 0,
> +		       current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
> +		goto out;
> +
> +	__show_regs(regs);

Ah, remnant of debug code. Please ignore this line; I'm not resending 
for now because I fully anticipate a v2 (and possibly even more). Lack 
of coffee/tea and presence of beer during weekends aren't going to help...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

