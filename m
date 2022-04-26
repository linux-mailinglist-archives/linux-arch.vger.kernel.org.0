Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3E50F0D1
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 08:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiDZGVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 02:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiDZGVM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 02:21:12 -0400
X-Greylist: delayed 1230 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 23:18:04 PDT
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC35A13CF4
        for <linux-arch@vger.kernel.org>; Mon, 25 Apr 2022 23:18:03 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 23Q5vVcY063355
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 08:57:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1650952646; x=1653544646;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LL28OJv509egBstFeV2Ig3Njtp/Ayo/hHdAQn0ETPec=;
        b=gTsKG8h03jM5+ldaoVuW9seg+42gSUPi1UUMCBYzaW37vvv71V2MMiVaWgb68B7h
        4IAH43tZXzRgrXvJV+Jjfamj/mDoY1Nq2IW/SeNBCIw0jmV20mVosjqlbrg955i/
        pIC2fv2f2Vb8DaCPh3FBJbuyANOfQLKPzfiqXw5M08FQRPN3U626ODJuMSWSuhsn
        dY3haNb/mQBK1qGhOEb+byqJlvof3zRgLGaBbybbTmWmKcFv/R6u+DlLhq6rpT8b
        43n//0dJ7ryCVUhSMRW7US0KE7cqL/dgMJ1lsBNksbyUp9zquZty2cQpyUNYtpnM
        +EvhIdpaC46Bjypi2RE+2A==;
X-AuditID: 8b5b014d-f2ab27000000641e-1f-626789c58245
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id C3.C0.25630.5C987626; Tue, 26 Apr 2022 08:57:25 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <ff85cdc4-b1e3-06a3-19fc-a7e1acf99d40@ics.forth.gr>
Date:   Tue, 26 Apr 2022 08:57:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/13] riscv: Implement sv48 support
Content-Language: el-en
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
 <20211206104657.433304-8-alexandre.ghiti@canonical.com>
From:   Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20211206104657.433304-8-alexandre.ghiti@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH973n6Xmezo5vV/jKsF0MISw/vtTC2HpMfi3ze+Oqx/VL9HQ1
        vx3ydN1hV6R5dPTjSsVC59JdIlnESlcNpd24MnNNhAiN0cXWf6993p/3+/3ZPgwhf0n6MjEJ
        ao5PUMYrKCmp35btN6suXRUx5+a5QFyWb/fA/RnZNE7t/eCBLQMijX/0fQT4V+ZDGuutWgK/
        qUkD2OAUaJz2qZrAjzptJC65WifB9mPtNC5++0qCG/S7sdb2lcR5gonEgvMlwK22HApXfEml
        cFZ9F4ldracIfPlTL4UFcRR+ZLlF4F7HRWqpLzvwMxOwWQMNJCtqTlPsRU0zyb53uUj2gbaP
        Zq2ig2Zzy5PZOxmPKfZupRmw5aXpFGt1LmLNpqNsVbuGYgvOnPVg28TN67y3SoOjuPiYFI6f
        HbJTGv3678F7NfJ9TelGWgNKR+qAJ4PgPNR2wkDpgJSRwzqAclL7wJCwCJk/u8hBlsElqKtM
        oAeZhFNQY3kHMTT3Qo8vvHHvjIabUZEty83eMAjdtJjdOQQci2wtOslggQ+sYVB9r9EdJIeH
        kenJOzdTcDq63HL/r5lhPOEKlP5NPeRdgHQW3b+cSeh2Tw5hAKPEYdXisApxmEUcZskFZCmA
        ypTAgJjIpIBde3h1dICKLwfu94PVlaDD3BNQCyQMqAWIIRQ+sqwpuyLksijl/gMcv2cHnxzP
        JdWC8QypGCuj326KkEOVUs3Fcdxejv+vShhPX40ERDqrT9pvREQvb6yyLR7Zlg8tE88fmqCI
        LNqy9nl/Siq89O1glDT8Wr598tQSR2PIVB+bv/lHN0z0exrkLxRKqrbLuaYKXWhlact0LdR3
        tJnzjBmGLV1SU0H1jnFHRqwpenB//k/HEiGxInZOdzOZ2KrqDj/F+7vCus9Vh60MNlQCB0Gk
        5RbeE7zM9jFN1lDvS2vHnS0JWv9bMiK3+Pv+1/mynuvqbGeB/vO7muCBhNiqkMS40ECDX/8R
        r9irB7XWmZ2zjM9ySmQ+T6c9+74hLlJV1t5wRedYMSNPWmesCd8YVhy7bKewynQ32WPiws4X
        25ufK3+tmly/5rhYOLu/RUEmRSvn+hN8kvIP4RAOL20DAAA=
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Alex,

On 12/6/21 12:46, Alexandre Ghiti wrote:
> 
> +#ifdef CONFIG_64BIT
> +static void __init disable_pgtable_l4(void)
> +{
> +	pgtable_l4_enabled = false;
> +	kernel_map.page_offset = PAGE_OFFSET_L3;
> +	satp_mode = SATP_MODE_39;
> +}
> +
> +/*
> + * There is a simple way to determine if 4-level is supported by the
> + * underlying hardware: establish 1:1 mapping in 4-level page table mode
> + * then read SATP to see if the configuration was taken into account
> + * meaning sv48 is supported.
> + */
> +static __init void set_satp_mode(void)
> +{
> +	u64 identity_satp, hw_satp;
> +	uintptr_t set_satp_mode_pmd;
> +
> +	set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
> +	create_pgd_mapping(early_pg_dir,
> +			   set_satp_mode_pmd, (uintptr_t)early_pud,
> +			   PGDIR_SIZE, PAGE_TABLE);
> +	create_pud_mapping(early_pud,
> +			   set_satp_mode_pmd, (uintptr_t)early_pmd,
> +			   PUD_SIZE, PAGE_TABLE);
> +	/* Handle the case where set_satp_mode straddles 2 PMDs */
> +	create_pmd_mapping(early_pmd,
> +			   set_satp_mode_pmd, set_satp_mode_pmd,
> +			   PMD_SIZE, PAGE_KERNEL_EXEC);
> +	create_pmd_mapping(early_pmd,
> +			   set_satp_mode_pmd + PMD_SIZE,
> +			   set_satp_mode_pmd + PMD_SIZE,
> +			   PMD_SIZE, PAGE_KERNEL_EXEC);
> +
> +	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
> +
> +	local_flush_tlb_all();
> +	csr_write(CSR_SATP, identity_satp);
> +	hw_satp = csr_swap(CSR_SATP, 0ULL);
> +	local_flush_tlb_all();
> +
> +	if (hw_satp != identity_satp)
> +		disable_pgtable_l4();
> +
> +	memset(early_pg_dir, 0, PAGE_SIZE);
> +	memset(early_pud, 0, PAGE_SIZE);
> +	memset(early_pmd, 0, PAGE_SIZE);
> +}
> +#endif
> +

When doing the 1:1 mapping you don't take into account the limitation 
that all bits above 47 need to have the same value as bit 47. If the 
kernel exists at a high physical address with bit 47 set the 
corresponding virtual address will be invalid, resulting an instruction 
fetch fault as the privilege spec mandates. We verified this bug on our 
prototype. I suggest we re-write this in assembly and do a proper satp 
switch like we do on head.S, so that we don't need the 1:1 mapping and 
we also have a way to recover in case this fails.

Regards,
Nick
