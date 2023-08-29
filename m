Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7745478BF92
	for <lists+linux-arch@lfdr.de>; Tue, 29 Aug 2023 09:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjH2Hr4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Aug 2023 03:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjH2HrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Aug 2023 03:47:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAD8132;
        Tue, 29 Aug 2023 00:47:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf078d5f33so32449645ad.3;
        Tue, 29 Aug 2023 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693295240; x=1693900040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjk+FpfUelxVelibnKbEkl69qBJN6BFpdKQWHtxAsVE=;
        b=g40ObASf0pgcyiV9W8yW2e0ImFv5tHz8ftNt59C8NfJptPg77pYhoWEpEMYR8HI2Rb
         Bpk3owu+9nUt1xD2kFRFdRT5yugyPE0v9DrwDsQxmz1IVYcqry9M+qlPirMav5rKr//B
         cHeqxLX/U2ASSFP8E2N1XEgKmxFo476P5fWESL5uo2M7xm3tLJOgmmR2fWU9ZYCze0o7
         o/Gjk2FiFKLs5ygkQDD91pnwuA1aqcAlvIrrI/DhPzUg+q87DPTyTGiYTidDc8VY1T7U
         694cjnroUQWaxseFLzXd6i0sOIpH8vjLvt8YY5cmyGOwojnKq3PBO7MCgc7O9NlbEK8a
         cVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295240; x=1693900040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wjk+FpfUelxVelibnKbEkl69qBJN6BFpdKQWHtxAsVE=;
        b=HnCgPv6EflVY78eZVQa5Ahs6ti6COwg6+rJ7jM8gNyKavsuA/couqaEKQ0Rk2owxgM
         FbX8zSAWbXJYo1XbB0Wv1FyWKrMa+ZB0wCKJKJYm9LviC7lH6a560Pp2wAbd8wafrc6p
         bVK9xFOPsKX8yYVv2aXAyGymwAYuc3Flj5mH+9wf4Jt55fcUwVGMEh809jclr40yUhGs
         JaWGUQeV6YKPjQMvJYTzDqxozIUXELpl7bJa0uLVenL8+1UbalLDjU/rA7BisiXdxgGu
         3zjqSFSRCwW+nl1JNaVUc22klUHAmPfZT6kl63qMkgUTrI37xAZ4Rqj9kULCir5/66B0
         9mcQ==
X-Gm-Message-State: AOJu0YwqW+zYNsbCfLwEJpSxF/QUm/hYUCoBuluB+brtNX8kr2Nl9tSv
        b3jkr9iTYvYrjihQTBaEQnY=
X-Google-Smtp-Source: AGHT+IGw54N/EbGI0oaZtyO8Gk5wcuxmUksLmpq7UNV2yDhMyCl7lrE7QumeCWn0XaSEDyQz3depfg==
X-Received: by 2002:a17:90a:ca14:b0:268:15f5:9191 with SMTP id x20-20020a17090aca1400b0026815f59191mr25533177pjt.36.1693295240008;
        Tue, 29 Aug 2023 00:47:20 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b001b03f208323sm8642247plr.64.2023.08.29.00.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:47:19 -0700 (PDT)
Message-ID: <836d554b-64a2-cc16-a361-29ce5cdd07e7@gmail.com>
Date:   Tue, 29 Aug 2023 15:47:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 10/15] x86: hyperv: Add mshv_handler irq handler and
 setup function
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-11-git-send-email-nunodasneves@linux.microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1692309711-5573-11-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/18/2023 6:01 AM, Nuno Das Neves wrote:
> This will handle SYNIC interrupts such as intercepts, doorbells, and
> scheduling messages intended for the mshv driver.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> ---
>   arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>   drivers/hv/hv_common.c         | 5 +++++
>   include/asm-generic/mshyperv.h | 2 ++
>   3 files changed, 16 insertions(+)

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

