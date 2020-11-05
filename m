Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544312A84FB
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgKEReF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 12:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbgKEReE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 12:34:04 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3627C0613CF
        for <linux-arch@vger.kernel.org>; Thu,  5 Nov 2020 09:34:03 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t22so1110646plr.9
        for <linux-arch@vger.kernel.org>; Thu, 05 Nov 2020 09:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=smObYvB7UrNcMPo3P/gpfiQDzpAY2JnzU7bqWocm15Q=;
        b=TjFj1/11pI29VIxZ1hX/0ytTD/fL3xmC/oL//nL63LWvJR5eahIyyvYJPYizEzEYbW
         +ZIL6Cuyh8F/whBD+ZbeZf4kMz8/xJOxHoG7r7oTfm7+TAWnnZ2GLA1Y1wcnVNxfz+j7
         z38KrSTxH7D4GKklTAbc+uTZDAs4B1P+6fWBT+USAe0xjB6giWYn4015KsT4/jFSSGiA
         Goa3O+kEbmKS6i/5UIsMV9JJiYbVtn+RhThQ4jKQOsMog2t3c3Hcq6qq0WxorJZQLk1Y
         RRsFPzzQlbeWAKHMGx1iePrEx52qWxy3gYNE97jw6b7Fo4yz1vEShr9rbZ5rqR35+W6q
         150A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=smObYvB7UrNcMPo3P/gpfiQDzpAY2JnzU7bqWocm15Q=;
        b=M6hjkw4CpdeFsjA62Bs5l5MuvtrYm0JMmfdyY/IwtNzwPRZVN45X2iWtyCygmDUqoW
         bxkiY7L6qsz3pBHLoIkLHAvMdJ2rXREO03ymwmgZkCc0UDNBYzTEyP8v3A+tx1aztMEa
         qJNcZ60FXbgtUliJGtOIaFfqOiETLN0HXMlJ4cKlg0+7b9eHsVK2WTj0/9xX8rqKU5UH
         hrTi72HKa4W0iMmpowJbCYt6qyD3w22pJpUDM8W42Enqun1LT9P2MiaNF3OJNpFiVil6
         IEoJcJoDS4zoys2gwLgzpJXXOqGXWIr5Q/LXGNzx/3O5fXFIffipxhzp1yvaXAqsaBCX
         fzGA==
X-Gm-Message-State: AOAM532IBXAWBD1ck6g4WhvIaE1T2Wmb2D6YdidBI6gkht4oKkc1ewHu
        nHXXJe0sZuTKxb6m6ln0WWcw5Q==
X-Google-Smtp-Source: ABdhPJyg49tn1L5mM+0reqlQrplb5ljU+nTGL0n2a4GRUYdECxV+5+PQYi+ME7A6CaDdqAfQjtjO/Q==
X-Received: by 2002:a17:902:8f88:b029:d6:d62c:e437 with SMTP id z8-20020a1709028f88b02900d6d62ce437mr3221904plo.73.1604597643292;
        Thu, 05 Nov 2020 09:34:03 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h184sm3022962pfe.161.2020.11.05.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:34:02 -0800 (PST)
Date:   Thu, 05 Nov 2020 09:34:02 -0800 (PST)
X-Google-Original-Date: Wed, 04 Nov 2020 14:28:21 PST (-0800)
Subject:     Re: [PATCH v4 4/5] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
In-Reply-To: <20201006001752.248564-5-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, greentime.hu@sifive.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, anup@brainfault.org,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <Atish.Patra@wdc.com>, catalin.marinas@arm.com,
        david@redhat.com, Greg KH <gregkh@linuxfoundation.org>,
        justin.he@arm.com, Jonathan.Cameron@huawei.com,
        wangkefeng.wang@huawei.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, rppt@kernel.org,
        nsaenzjulienne@suse.de, Paul Walmsley <paul.walmsley@sifive.com>,
        rafael@kernel.org, steven.price@arm.com, will@kernel.org,
        zong.li@sifive.com, linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-325cf154-5f4d-41fc-8ad1-2a29a7068f33@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 05 Oct 2020 17:17:51 PDT (-0700), Atish Patra wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
>
> These two functions are used to distinguish between PROT_NONENUMA
> protections and hinting fault protections.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 515b42f98d34..2751110675e6 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -183,6 +183,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>  }
>
> +static inline pte_t pmd_pte(pmd_t pmd)
> +{
> +	return __pte(pmd_val(pmd));
> +}
> +
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> @@ -286,6 +291,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
>  	return pte;
>  }
>
> +#ifdef CONFIG_NUMA_BALANCING
> +/*
> + * See the comment in include/asm-generic/pgtable.h
> + */
> +static inline int pte_protnone(pte_t pte)
> +{
> +	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
> +}
> +
> +static inline int pmd_protnone(pmd_t pmd)
> +{
> +	return pte_protnone(pmd_pte(pmd));
> +}
> +#endif
> +
>  /* Modify page protection bits */
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
