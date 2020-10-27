Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC729C781
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 19:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789490AbgJ0SdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 14:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1793634AbgJ0SdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 14:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603823582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUoo3HhPrykGvwK+MAKTfL5A7J2hnAQhpsgsVSSSXlo=;
        b=YiNGS7LG30KUSOFkFv0MoVPFhamWddSuqxZKS/InxZYJmFIT5srP4w2OxRuGfASqHikqYT
        /Vd5Dx59KON/5o96+kb5w7QARMGm9QGKEsSF5irPlwRyGHhSBFyWDV1iitqvDvFYmXgrs0
        EgmcfKkf9/JOMaNql4V6D9mH6hadGhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-S836uhR2O62vSdU1osWGqw-1; Tue, 27 Oct 2020 14:32:58 -0400
X-MC-Unique: S836uhR2O62vSdU1osWGqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DBC0101F7A2;
        Tue, 27 Oct 2020 18:32:55 +0000 (UTC)
Received: from ovpn-66-71.rdu2.redhat.com (ovpn-66-71.rdu2.redhat.com [10.10.66.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2927C5C1C2;
        Tue, 27 Oct 2020 18:32:54 +0000 (UTC)
Message-ID: <e58049812c833ac85f9241ab096b220b0a4d996b.camel@redhat.com>
Subject: Re: [PATCH -next] arm64: Fix redefinition of init_new_context()
From:   Qian Cai <cai@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 14:32:53 -0400
In-Reply-To: <20201012141032.6333-1-cai@redhat.com>
References: <20201012141032.6333-1-cai@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-10-12 at 10:10 -0400, Qian Cai wrote:
> The linux-next commit c870baeede75 ("asm-generic: add generic MMU
> versions of mmu context functions") missed a case in the arm64/for-next
> branch.
> 
> Signed-off-by: Qian Cai <cai@redhat.com>

Arnd, Stephen, can you apply this patch? Those compiling errors are back again
in next-20201027.

> ---
>  arch/arm64/include/asm/mmu_context.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h
> b/arch/arm64/include/asm/mmu_context.h
> index da5f146e665b..cd5c33a50469 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -176,6 +176,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>   */
>  void check_and_switch_context(struct mm_struct *mm);
>  
> +#define init_new_context init_new_context
>  static inline int
>  init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {

