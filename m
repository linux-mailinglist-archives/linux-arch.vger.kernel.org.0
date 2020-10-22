Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE62957FE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507980AbgJVFiy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 01:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507979AbgJVFiy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Oct 2020 01:38:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE21C0613CF
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 22:38:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so531602wmi.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73Kve3eCD9lFW3ilOeR8Q08ZRzYRtk6HhqwKqUbeckQ=;
        b=SltHHrVlBKjJCfSt8WOzpbmWAyyApuzoEfOWBWk7w1rI4ddOMh3Jq3VYGO6SDozaCi
         qbhKgg+BGotFSLTM3VTwCagdIHZtGQZ0qJfb8YTKuuAMgpSQTOKj52jRrdmipBKo10IT
         7+IQukUEWnptNNCdytAifO1CErMOIHDbTXJXhjMOjlqbGSzttrbK689GXJYOm0n7wUPN
         7n6M2HFMlorVQqLiU+y1EPf5WjXsACSieJ6qr3wGLpT7RaSZwdP9ITxTxW9sN/3RQF5B
         9WwtjZBkREl4Z202ODJZ5nh5u9I1Vuq9TnHTOFjI2bl56AiCSh02aUn6m6OBM5pfFhVi
         C3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73Kve3eCD9lFW3ilOeR8Q08ZRzYRtk6HhqwKqUbeckQ=;
        b=UBVUg3r0T20r/ZZjT5uzFPzglR8kC+upZosy7Jc1GbGGlFvlf/sDKah5NuIs0AVew9
         P7C2jpSOz+YpILUlJGNHwLkbted3/iUJ6pnXTu6r8iH9rbZHO3EYoScyDfOiy//Wl/2/
         KCJwBtiPNNsqtMsrup1q4r33kj79T6vsLdjQvKsNG6bjHiI4SYiPEzpcBShDePyr40+x
         9l1FxvQKLZfgmqF18RPDdWxaf+xya8ptouYWeVFcy4DyIhwKAClUP8oMusSwhs/GJ++I
         yVHqeonWsVp0LPJe45nqz+8rM+3Ew7ZvEpJym9AfUYfOPmk2s4UAT/VSST96w51YeXv9
         8img==
X-Gm-Message-State: AOAM531WyIVLcTuUycxgnAQbA2CP/S28g81+Vukv4+Ub2HNm2YyHpeSi
        oH9l2nMb2s8BR7w5s909aNZOAX+T7Fa15EoluhWZ/Q==
X-Google-Smtp-Source: ABdhPJz1BooD6m8TpdqoamMg/85PKq4UWpiLSY1nMNpSndxeEm8puevlbLhaB83QxyD64aWlreMZigK0s/qSSC/3jVo=
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr834132wml.134.1603345131488;
 Wed, 21 Oct 2020 22:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201006001752.248564-1-atish.patra@wdc.com> <20201006001752.248564-5-atish.patra@wdc.com>
In-Reply-To: <20201006001752.248564-5-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 22 Oct 2020 11:08:39 +0530
Message-ID: <CAAhSdy162QfyxGTn=UnEDnZ3OgKh-GN=bwgQ3jpWrp1ZMWKw8g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] riscv: Add support pte_protnone and pmd_protnone
 if CONFIG_NUMA_BALANCING
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arch@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 5:48 AM Atish Patra <atish.patra@wdc.com> wrote:
>
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
>         return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
>  }
>
> +static inline pte_t pmd_pte(pmd_t pmd)
> +{
> +       return __pte(pmd_val(pmd));
> +}
> +
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> @@ -286,6 +291,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
>         return pte;
>  }
>
> +#ifdef CONFIG_NUMA_BALANCING
> +/*
> + * See the comment in include/asm-generic/pgtable.h
> + */
> +static inline int pte_protnone(pte_t pte)
> +{
> +       return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
> +}
> +
> +static inline int pmd_protnone(pmd_t pmd)
> +{
> +       return pte_protnone(pmd_pte(pmd));
> +}
> +#endif
> +
>  /* Modify page protection bits */
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
> --
> 2.25.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
