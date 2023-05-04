Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D886F7044
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDQyz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjEDQyw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 12:54:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698472680;
        Thu,  4 May 2023 09:54:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f145d1b85fso126994e87.0;
        Thu, 04 May 2023 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683219287; x=1685811287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWuEZkogQrpROHMVf4Afmv59RhcW/mBv705XzrKNcwg=;
        b=h1I5pt2pWUP0tbSvoq0HGWi7cXdL88LVYVgOA2PXd8xYgjLSlbQvcg9QCTSZAhYNFT
         4bnY0fpW/OZZjtenYMNv+t5oxb2Iq6wBEUBwMrjGB4rXeFLMg9szxoupOANF94p5n8bj
         FBv5gEKq2+Jmk/4uyuBySWmNZly1MR6IgZUgT6QAFaOw9ajC0OmWdL5c32u1qh46vVl+
         zwaubiKXwu0Xqsl3f7f0oWmfje8ESf0x2TlppY0KKMj78gfn93skK/6445rl5jDCCsqO
         LH06f7LFAT6E6NtYTbDymF2OWWTJTe3pJURWuQAsyp1uYcSg/QPtnBz5Ku4DAb/K2b2K
         0cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219287; x=1685811287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWuEZkogQrpROHMVf4Afmv59RhcW/mBv705XzrKNcwg=;
        b=HMcrbk7lth7JPPzy/LlpDBg0H6YvM8XdFGkDa3d8vxuF+v6OnDYJJbr9Firrb/N2TM
         dL0HGbcSyyQ9PbDZaJ2pcI1dJ6s85GhCWa9kiYzSIYZMy7Ib1GlZ8AwfYMuZFCUMZibz
         X4CD/lBnAecBwUOfgSIatHP9IPsGjpmpWYIke15Uwpc8Fb2GNYkVcwYRt9XVwDfJt9fs
         jnv6a/UtK3wxeoXpy4rtHVQ7WDqT7kUtizd4ma0vZgdqia80uJ71MCXtWcc3yxbz10a4
         45gbsqAwQYqHBE1qDUfcy2AKvauMnLQnp2KmipcSoytTNThUyU42GeZQ0luZ4BHzCQCK
         l8YA==
X-Gm-Message-State: AC+VfDwD9iia89vKtXEQO/xTbQPaniDZQqeH0Wqdxv/XBbrTpv1t2LrL
        R2TkxARdIK5agHquwTJFHuU=
X-Google-Smtp-Source: ACHHUZ6DCMzKDQdWDNz5XYVj6UKhn7SpghglT8y5gsikn9UDjxEKWrx/AKn5edWATVXtU+lNPN+nLQ==
X-Received: by 2002:ac2:44d5:0:b0:4ea:fafd:e66f with SMTP id d21-20020ac244d5000000b004eafafde66fmr5317924lfm.0.1683219287470;
        Thu, 04 May 2023 09:54:47 -0700 (PDT)
Received: from localhost (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id 10-20020ac2568a000000b004edc7f6ee44sm6495865lfr.234.2023.05.04.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:54:47 -0700 (PDT)
Date:   Thu, 4 May 2023 19:54:28 +0300
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V5 05/15] clocksource/drivers/hyper-v: decrypt
 hyperv tsc page in sev-snp enlightened guest
Message-ID: <20230504195428.00007eda.zhi.wang.linux@gmail.com>
In-Reply-To: <20230501085726.544209-6-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
        <20230501085726.544209-6-ltykernel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon,  1 May 2023 04:57:15 -0400
Tianyu Lan <ltykernel@gmail.com> wrote:

> From: Tianyu Lan <tiala@microsoft.com>
> 
> Hyper-V tsc page is shared with hypervisor and it should
> be decrypted in sev-snp enlightened guest when it's used.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V2:
>        * Change the Subject line prefix
> ---
>  drivers/clocksource/hyperv_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index bcd9042a0c9f..66e29a19770b 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
>  static union {
>  	struct ms_hyperv_tsc_page page;
>  	u8 reserved[PAGE_SIZE];
> -} tsc_pg __aligned(PAGE_SIZE);
> +} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
>  

Out of curiosity, this is not a on/off for VM with paravisor and full-enlightened VM, how
does change affect the case of VM with paravisor? I assume the VM with paravisor works fine
without this previously.

>  static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
>  static unsigned long tsc_pfn;

