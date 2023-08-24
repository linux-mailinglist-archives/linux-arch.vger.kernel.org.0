Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A615B787221
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjHXOrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbjHXOrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:47:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1F1FF5;
        Thu, 24 Aug 2023 07:47:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a410316a2so3412046b3a.0;
        Thu, 24 Aug 2023 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888413; x=1693493213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ+KTDR8wR2AOEp41hFS/dpjHwcNvA7RwPrlUly9aow=;
        b=KpfnOd3vdyD4nQClcLyPckRwxPStbsl88Zj+GpP4QICkiquuEx99obKZuCnQj84qCF
         cfRomPB0imwC9xcOXtA2Nrgm+Hv76MFQJ4Dw4d0bdRpVnBAahs/VlV4fkjz9rv/oqSjt
         Wy7mf5o1oPTRGdEreBMNQChOOVYcA8bP89dzz0T0wtBgwXI+e8RJbxi8mqjn/LYO7e+/
         2egQohcTxNy3hxJcSzhwz2FYni3uJ2Sykv0xuS/3OkLoPR7HLYB82VwSzQaxCfUa0Ujd
         g3RUJU5nJFA9r9fz6NNHjMpMnZtKeL2ElPZVI/k90Did19GZ0/zDeK0yuCmiaDl37ZbZ
         EGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888413; x=1693493213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJ+KTDR8wR2AOEp41hFS/dpjHwcNvA7RwPrlUly9aow=;
        b=PBPt26uOTQSuHFQy8lZY+aZW2DwXodmDAJxcFMvilXwRqd0zVkdXeFg/+oCtIWlT5J
         q/QA5PB/kmyvtU9mDWyNNdcR8tRrEvMhE8/RKBTPVVQlg65T7hMKaJBHngkv8JHym/e/
         6rHpF1On0UgpKRBcMf1Bx6CFyvPlNnz+vQ2mhqxlxa/4ZL71znsDaLYk3KCZ2Aqzl1h9
         uWnAcxVJdhMGJdwjluyb81C4EMWWLOuq5Ox+qW6VMbxXSqU+jYUInRBQ4BN1X0ttJKEw
         VNS8JDQMLI1e+RBtPDn2GqKI9Aju9m2Nk/zEsSlUbvP/Gusmr1xBD/+cmD4qn4Krlgo1
         2RXg==
X-Gm-Message-State: AOJu0YzuVrKzP+tGhZ8OwewlhFzsANUcS08/2PIpIJHtDtccaYGusfLQ
        CgwlNkFtWtblnxTEuoCM5h8=
X-Google-Smtp-Source: AGHT+IHUAUmyZfJ4cJMVcs+fGHTN6JFXYUmuC2Qait9zuRI9fhVdY6VJsF0s3wboXBY7sU/bs3AYkA==
X-Received: by 2002:a05:6a00:1949:b0:68b:e29c:b5c with SMTP id s9-20020a056a00194900b0068be29c0b5cmr4424217pfk.27.1692888413268;
        Thu, 24 Aug 2023 07:46:53 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b0064fd4a6b306sm11137228pfo.76.2023.08.24.07.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:46:52 -0700 (PDT)
Message-ID: <ef11fd79-006d-1af2-b2ce-e532703de007@gmail.com>
Date:   Thu, 24 Aug 2023 22:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 10/10] x86/hyperv: Move the code in ivm.c around to
 avoid unnecessary ifdef's
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
 <20230824080712.30327-11-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230824080712.30327-11-decui@microsoft.com>
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
> Group the code this way so that we can avoid too many ifdef's:
> 
>    Data only used in an SNP VM with the paravisor;
>    Functions only used in an SNP VM with the paravisor;
> 
>    Data only used in an SNP VM without the paravisor;
>    Functions only used in an SNP VM without the paravisor;
> 
>    Functions only used in a TDX VM, with and without the paravisor;
> 
>    Functions used in an SNP or TDX VM, when the paravisor is present;
> 
>    Functions always used, even in a regular non-CoCo VM.
> 
> No functional change.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
