Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D53773B38
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 17:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHHPqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHHPpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 11:45:08 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38033A9A
        for <linux-arch@vger.kernel.org>; Tue,  8 Aug 2023 08:40:38 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso89652761fa.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Aug 2023 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509177; x=1692113977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wSCMvsrvGtP/SRB0drN+VU/GnJ3+psGhnVmypWifVc=;
        b=bVuLt4KooN2Oz4kVydW6KGEjnnTVwjpLc43E+GPPqxp7FMmVtdk2APizoD2mMkV9+u
         XnxoOmc8qNkvHhVwtbUQemOKTEAzTuki/t70o36TnBhAluGfcsdxPxaCiFnbUN2PrIFC
         xXU4yr/BM85dfG5WaqVFSRaKF1wb2gFE2GllcdOHM/+U5UsYUJN6CcQFVArcPKGeJYIY
         lG75HY7vIoLv9qR4I85azbpUM4gNK/0T1YRst7OBrjdBZQuhbDr57Q5GwCKEefY/xncU
         04wwEDg0s8NsSJ2LxuRa6d2fjV0vkse6qjHDFCXixYB0Fds3n5bFXUhBHS3DRXNUjYM2
         rvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509177; x=1692113977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wSCMvsrvGtP/SRB0drN+VU/GnJ3+psGhnVmypWifVc=;
        b=b8PZItTN3i3+tyWERR5HMDOwUQpDuVqebzO9QXHE8zZXeVODViAnVwX+P4koBXOieU
         xqiyFeLYRhTG1PMg0b6jNOPlq4af7Kb2jNVpyZEJ5kuhs5i1Hd6z/yCm2rgjjTeWY/ea
         aYFs+tHt0impSY5ExiSXBOmaBC9LyVavXccwHo8g4zj3TfqTkm+0w5n34JvtTdRkKuHc
         DrZuUiVWxm4DuoqeMPBBT/HNo31ztWzM2T/VUhZnuQpKmQhlhupsrUvGt7bolFThQXXl
         z3KOTyeGPryYfjaJUoLQNvoMLerSol21qnxPgOx5eToVQl6jU9wIgjPBaxr7jxZxMuYG
         dZGg==
X-Gm-Message-State: AOJu0Yyi/Ex6HcRU+4WAbs4IglR7ueiqcQ5QXUyqluz4l2my+8m4mbis
        Zx3CWxjeq+R1f4slmGfHMP5Dl23YrmuadAAncqQ=
X-Google-Smtp-Source: AGHT+IEt+Kf3mPdgxinq+Mt4SlVaTOKw94gaghcqyMPjmABWGoq+4o6zGEM2ZElSHkgdewFxWTvliA==
X-Received: by 2002:adf:ff8c:0:b0:317:df3e:13d with SMTP id j12-20020adfff8c000000b00317df3e013dmr5441304wrr.38.1691487443405;
        Tue, 08 Aug 2023 02:37:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.177.253])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm13073883wrs.30.2023.08.08.02.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:37:23 -0700 (PDT)
Message-ID: <cbc22d2f-726d-86fc-1f34-c529cd91fdbe@linaro.org>
Date:   Tue, 8 Aug 2023 11:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mips: remove unneeded #include <asm/export.h>
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230807153243.996262-1-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807153243.996262-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/8/23 17:32, Masahiro Yamada wrote:
> There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
> is unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/kernel/octeon_switch.S | 1 -
>   arch/mips/kernel/r2300_switch.S  | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


