Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1C7871F0
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbjHXOlO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbjHXOku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:40:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E81BD0;
        Thu, 24 Aug 2023 07:40:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso866046b3a.1;
        Thu, 24 Aug 2023 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692888048; x=1693492848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRZJ8WLdNUtwbd6Zj6FND3gfoh2xaAfgX5+bdKbrRXk=;
        b=oXtC/N5Gs222b5v3ayuTlDMyRiqBSbnaKFHFMcjOt2o/miQtOru5bqHlklCe/jnFcS
         CtbFIomTw4ncUAwRvbWZ1KE3wqa617acHJz68ijxaCAh/OZjqRM7JDMjQS0j87ddC7Vk
         b6oF7+b7W9ZmVbmIJfTiwOucNkxZEFSuNhhY/FAdSuKlVvPIO+CY/7rKnAyTXQKDTXew
         v0kxRyaezbBA0ee8+E+XfKT/74mdAU6DPfB/pJsbfWe53AJYAFRSzvZLnszINQ1C0v51
         +HNNqrkY8erKdF8NAdvVUSTKOoFj+bWrXVJwecfaKmb1Ym7LgGDFWgmnB5tAmeNdHUgE
         LYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888048; x=1693492848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NRZJ8WLdNUtwbd6Zj6FND3gfoh2xaAfgX5+bdKbrRXk=;
        b=Sh5C3jry9FBtasX23Cd9UPelt6RN+24Tl2zJrjcsfGgDhTdhB3aBaZjHR7lzJ2ssoc
         O5Ibvi6pISb141wcavSMOjn8dIy2UFdR8/2qPckgiQItrdloNIvrdpS7ehn/wsXVfCwe
         AeP0nnS0eZAG6smQ9Ui6E/qaZEPGkqGfgQfHAE95N12kDccOV84CfcWvNt9yhDpKeoHY
         1luyG67W/7KEEBSgnNiwE9EAm8Wo7QQr/R5+pH17+qhvgum0GIaTJCaeWUVT0IaQiQ0T
         K+yfIPi8sgbVnp2Z3L61UxMWtLyHR8JphWc5rETWq3zVmzTpnxUII6W5BWQYMNZLDK4W
         aTMg==
X-Gm-Message-State: AOJu0Yxf4jIMupUYEGUNvL/Ewntpo35T3n5k6EhtBDBL+jaXauhA8lvB
        6njG89jWCNNoStfST3YvQNQ=
X-Google-Smtp-Source: AGHT+IFwWJLjncKJbAcJdgvguJDoxFZXYwHHfrkVbhQdE1TsDZbojjMoSEulIM3HVwkSfG7NyrQd6Q==
X-Received: by 2002:a05:6a00:15d0:b0:687:3f06:5939 with SMTP id o16-20020a056a0015d000b006873f065939mr17131871pfu.32.1692888047777;
        Thu, 24 Aug 2023 07:40:47 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b00686bf824b3bsm11159146pfo.136.2023.08.24.07.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:40:47 -0700 (PDT)
Message-ID: <a124df72-4231-4589-cd2b-4c0a77fab975@gmail.com>
Date:   Thu, 24 Aug 2023 22:40:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 07/10] Drivers: hv: vmbus: Bring the post_msg_page back
 for TDX VMs with the paravisor
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
 <20230824080712.30327-8-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230824080712.30327-8-decui@microsoft.com>
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
> The post_msg_page was removed in
> commit 9a6b1a170ca8 ("Drivers: hv: vmbus: Remove the per-CPU post_msg_page")
> 
> However, it turns out that we need to bring it back, but only for a TDX VM
> with the paravisor: in such a VM, the hyperv_pcpu_input_arg is not decrypted,
> but the HVCALL_POST_MESSAGE in such a VM needs a decrypted page as the
> hypercall input page: see the comments in hyperv_init() for a detailed
> explanation.
> 
> Except for HVCALL_POST_MESSAGE and HVCALL_SIGNAL_EVENT, the other hypercalls
> in a TDX VM with the paravisor still use hv_hypercall_pg and must use the
> hyperv_pcpu_input_arg (which is encrypted in such a VM), when a hypercall
> input page is used.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
