Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319635532D1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiFUNBy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbiFUNBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 09:01:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F4110FD0;
        Tue, 21 Jun 2022 06:01:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so18845399wra.4;
        Tue, 21 Jun 2022 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Y0ATUV8Qb4XZ2PUuFjYWiAEtClTIxxHJKputShJ2zA=;
        b=SxFRCysvo2ayNNvRxbNmb2m3TtNeYut7NtJ6Y+am/HXsSaVoL3J0TuLErblx443GDc
         EpZrC2rIylJZ/YJ72tFldX6Qpe2AoLBeBD3cBYRihIBWKd6KGbBTyZtqvpIEzzijZzLH
         a/ne8Gy9d3HjTKAsiy11MQPKGENUFt8lJX9iGe2rNdDaHL22U0fR52zebFJ//a7GeEl8
         415jHF5PqNOKmPt/mWITyZ6omTLM/onIHt7jILtV4Mor7b+afC4Ji1Xh+K8/A+kHC6k7
         RrMMAf7oegYrI8/wV5UWZ3jlE2xEQT9zVGz1GWJ+lZgeWhAowO1Nv6WSZBq2xdKJAVBn
         1NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Y0ATUV8Qb4XZ2PUuFjYWiAEtClTIxxHJKputShJ2zA=;
        b=OmMJvvUQ/6k+wtF89VIXDQX8c37tOM/ZwBMMjJLNpl9ie4+3JWvODy7PgVlDtt1DmL
         b8HB8r1+D2rQpuOGDg+ehfayDK1Cls+BvpeNJVYPmwe7fH2eTTjx10qm/yGwlQskV4Qx
         2AxejtVOZn/XxxA8yudVbaAyB+SCaxuhrgTrqa7kHpDCcPIjsUxLdRFx2+bUsnctfW7e
         8UWl4FLnx6wnjTiwET5AqQXeRB/ElMAT13v5dQDrp3kNq8ct00oFJEmwehuc0NG/awbB
         M4c12igixL98GTgVRsIuQ6XdMtkThFeR/+2jKojQfK3ivR3p0TrKP26iaXLym3l4fXP2
         02uQ==
X-Gm-Message-State: AJIora/9/j4Wii7/EWxidMIrOnvfcmPmfNOWFiJGzHfqTXYYQpr6MYvv
        uuDHFNDuUSBrNEFZUsCLE1U=
X-Google-Smtp-Source: AGRyM1vo+xb8luqoL3byYFbo+WDU6/cNpN4MpBrUrjsxEByYipZtEKB6XXcpChcQlOEJXq1ziaWg6g==
X-Received: by 2002:a05:6000:1e1b:b0:219:e32d:cbe8 with SMTP id bj27-20020a0560001e1b00b00219e32dcbe8mr28439512wrb.129.1655816486830;
        Tue, 21 Jun 2022 06:01:26 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b0021b9416fa13sm4608770wrx.90.2022.06.21.06.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:01:26 -0700 (PDT)
Sender: Alejandro Colomar <alx.mailinglists@gmail.com>
Message-ID: <3d18d50a-b96f-befc-d905-c9f68f7542ab@gmail.com>
Date:   Tue, 21 Jun 2022 15:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Content-Language: en-US
To:     Cyril Hrubis <chrubis@suse.cz>, linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, dhowells@redhat.com,
        David.Laight@aculab.com, zack@owlfolio.org, ltp@lists.linux.it,
        linux-man <linux-man@vger.kernel.org>
References: <20220621120355.2903-1-chrubis@suse.cz>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220621120355.2903-1-chrubis@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/21/22 14:03, Cyril Hrubis wrote:
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace for C code.
> 
> We cannot make the change for C++ since that would be non-backwards
> compatible change and may cause possible regressions and even
> compilation failures, e.g. overloaded function may no longer find a
> correct match.
> 
> This allows us to use the kernel structure definitions in userspace in C
> code. For example we can use PRIu64 and PRId64 modifiers in printf() to
> print structure membere. Morever with this there would be no need to
> redefine these structures in an libc implementations as it is done now.
> 
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
> 
> 	printf("%" PRIu64 "\n", stx.stx_size);
> 
> We get:
> 
> 	warning: format '%lu' expects argument of type 'long unsigned int',
> 	         but argument 5 has type '__u64' {aka 'long long unsigned int'}
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Acked-by: Alejandro Colomar <alx.manpages@gmail.com>

> ---
>   include/uapi/asm-generic/types.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> v2: Make sure we do not break C++ applications
> v3: Update commit message to explain C++ exclusion
> 
> diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
> index dfaa50d99d8f..11e468a39d1e 100644
