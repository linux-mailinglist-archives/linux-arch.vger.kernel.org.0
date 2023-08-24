Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FBC7871F8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjHXOmT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbjHXOmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:42:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60F1BC7;
        Thu, 24 Aug 2023 07:42:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf62258c4dso35222415ad.2;
        Thu, 24 Aug 2023 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888126; x=1693492926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vczamQd2qvjZwuPTJD2LOYVxVTQWNnyl+oI6XzgE4I=;
        b=c4KiV9K1VsrxuvJ1Q6gJEOY0WSbd9TQ9WaCPbv+geCTUOXV5BBuJG5wDF0kqYFLxPk
         j52RBlTHWBJXXX2bX9Ye/YsQf+f8OySBWvA3NsHqFYTIkdUYvBDQEpUwrwjbAzi2IrMn
         CcS5McQBNzwcLvohO0M1ZejOJMQ4mb8y0d1TnK6XUYC0+FmlwOOkHS3KDAs9CyFWtOYk
         F39tBA4ZU+3icUIIsm4/to8gJ8cSCJ4S20x+KoNqXOVwqsGOrtsgqGiBBBVqXIUpFBO1
         yk+enDqGaWbHMiJWDWpSGcOVM/0hG55YMLiHvzMltoEy7fSgX46q/A/NJFm9E5kNG2ed
         fB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888126; x=1693492926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0vczamQd2qvjZwuPTJD2LOYVxVTQWNnyl+oI6XzgE4I=;
        b=V1n0sMdMPX/u2548K4aIsV4L1SXWTqbvpTxkRlPTe3mqsm3VCkQqgo0vnFY7VT93fW
         pbIub2jr4i3qH234WsGG8zll8ynhx4ZFx3ISD+bmrNOQ6r7RyWgqiUsEz5Lxx2wJ+6Hu
         Wmp98PIyvRz3gw9N7EBZo5ZelDQhh2ejHhfaa5vC4cUe/kuWhPd4NkIzvzUKAbL75mzM
         NsDf/C9r0TgwOPN9yHvkTLYl2lVgCdq6fDt1UJU3EkfkHQC5i1sq5Fw7Hcl8lMGBOdvx
         KqsuJbJo/YaKPSGD6L8uB4GfjTZ6axvRrRgb99AQHPQ4pxmfbAbo6gXqA39qLVS5qJQJ
         x0UA==
X-Gm-Message-State: AOJu0Yz53SUuDzt1X3nzLXa7UpYmJPzbYK37mnIN7NAZJDBCUUM6cwqF
        JHUqR4xIbfd9zG4BDJf1NUo=
X-Google-Smtp-Source: AGHT+IE//VZgft2BWp9SgE+2G0VHhdyg8JVs3JrblH5/CB1neufrY3dkGq0LXpnlsUZu/t9tXkCLjQ==
X-Received: by 2002:a17:902:d345:b0:1bb:1e69:28be with SMTP id l5-20020a170902d34500b001bb1e6928bemr12325151plk.42.1692888125853;
        Thu, 24 Aug 2023 07:42:05 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001bc21222e34sm12827498plz.285.2023.08.24.07.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:42:05 -0700 (PDT)
Message-ID: <90bc229b-133d-f695-4459-3fad557a8fe2@gmail.com>
Date:   Thu, 24 Aug 2023 22:41:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 06/10] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-7-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230824080712.30327-7-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/24/2023 4:07 PM, Dexuan Cui wrote:
> The new variable hyperv_paravisor_present is set only when the VM
> is a SNP/TDX VM with the paravisor running: see ms_hyperv_init_platform().
> 
> We introduce hyperv_paravisor_present because we can not use
> ms_hyperv.paravisor_present in arch/x86/include/asm/mshyperv.h:
> 
> struct ms_hyperv_info is defined in include/asm-generic/mshyperv.h, which
> is included at the end of arch/x86/include/asm/mshyperv.h, but at the
> beginning of arch/x86/include/asm/mshyperv.h, we would already need to use
> struct ms_hyperv_info in hv_do_hypercall().
> 
> We use hyperv_paravisor_present only in include/asm-generic/mshyperv.h,
> and use ms_hyperv.paravisor_present elsewhere. In the future, we'll
> introduce a hypercall function structure for different VM types, and
> at boot time, the right function pointers would be written into the
> structure so that runtime testing of TDX vs. SNP vs. normal will be
> avoided and hyperv_paravisor_present will no longer be needed.
> 
> Call hv_vtom_init() when it's a VBS VM or when ms_hyperv.paravisor_present
> is true, i.e. the VM is a SNP VM or TDX VM with the paravisor.
> 
> Enhance hv_vtom_init() for a TDX VM with the paravisor.
> 
> In hv_common_cpu_init(), don't decrypt the hyperv_pcpu_input_arg
> for a TDX VM with the paravisor, just like we don't decrypt the page
> for a SNP VM with the paravisor.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

