Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A770F858
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjEXOLB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjEXOLA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 10:11:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66F11D;
        Wed, 24 May 2023 07:10:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d2981e3abso762634b3a.1;
        Wed, 24 May 2023 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684937459; x=1687529459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZXHIJ1hE3Wn+dGAzyqj5Sw4G3dlZ7dy5S0jADJahDY=;
        b=kolivbo7O//ztvRulM/fswXePIEri2OVOIH0rWnvUOK8CWvZKaz91KPME1yXlzHjPa
         hgNfJEFrCSHn3CdgUm3qUrUo7EOXsJZRuQ3h56WqxwLd165ztZEHoSiUTrmmnLOjV3eI
         8XIXRQUsTKr8fNEBAqvKJsI7rXPEemuKIUFu8O86W/w916R1nTUVMDcJ2C2+704LNwpo
         di+HzETrpEkeQRTxghmTOqT8lQ4S/cAdV0vK5BoZoIySGqqnPdFfFdAo95TvGrEIge26
         h9ItnPgmdn4FjlzxekTZFNl7Let8SnFQKsLN/lWYpmOLdJ/I5T/4MO4PecRgKZ30qLdK
         uUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937459; x=1687529459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZXHIJ1hE3Wn+dGAzyqj5Sw4G3dlZ7dy5S0jADJahDY=;
        b=ioNLCI0fVamEkLrmzSUs2MvIAeYMtT2M+yCiG774YxUIZogZGlbALZDVBJQXsz+3W8
         gZt3NUt5Qosii6E6L3LfIidrHGTwe5Edd20MfXyQuQfGpDOHfLgYb6/FTJ/LakR30Ye9
         fUEwKKFGgKQgTiU6s/ZKxiBUMViVTO+E0GS62EFDYjhQUgZFi35JZxPYdNrjKYPzUWXd
         09NaKb1hvzMQELsVHV34NRY2b0vhSZZ0Z3WLkFT2545EI0z6GpnHuI26LNj2BprZnxD4
         /jU1fjauvECUdHCY9OtkcRlbeywZFCLST4RMeVxS8o9Or+L2tPnjg0EmcZNxJIIJBaa8
         StOg==
X-Gm-Message-State: AC+VfDyh/hUo1XGDh7aUWRLlmS1YQ77AlYz9OtO84N3S/d4A08WNAnJE
        VBG6IckarVcdOfGk3EibL2Q=
X-Google-Smtp-Source: ACHHUZ7tROb/e++EO999/hYdjimsPclsdkSAE44Dy2aIvZ32lzmzELI9fDW2ryyZEdLApDmlJeEjvQ==
X-Received: by 2002:a05:6a20:7d96:b0:10e:2fd5:510d with SMTP id v22-20020a056a207d9600b0010e2fd5510dmr1307544pzj.11.1684937458962;
        Wed, 24 May 2023 07:10:58 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i20-20020aa78d94000000b006439bc7d791sm7520091pfr.57.2023.05.24.07.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:10:58 -0700 (PDT)
Message-ID: <c38c6875-7ca2-55dd-a1ec-ce7f903b795d@gmail.com>
Date:   Wed, 24 May 2023 23:10:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 25/26] locking/atomic: docs: Add atomic operations to the
 driver basic API documentation
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        peterz@infradead.org, sstabellini@kernel.org, will@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-26-mark.rutland@arm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230522122429.1915021-26-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 May 2023 13:24:28 +0100, Mark Rutland wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Add the generated atomic headers to driver-api/basics.rst in order to
> provide documentation for the Linux kernel's atomic operations.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-doc@vger.kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> [Mark: add atomic-long.h]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/driver-api/basics.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
> index 4b4d8e28d3be4..a1fbd97fb79fb 100644
> --- a/Documentation/driver-api/basics.rst
> +++ b/Documentation/driver-api/basics.rst
> @@ -87,6 +87,12 @@ Atomics
>  .. kernel-doc:: arch/x86/include/asm/atomic.h
>     :internal:
>  
> +.. kernel-doc:: include/linux/atomic/atomic-arch-fallback.h
> +   :internal:
> +
> +.. kernel-doc:: include/linux/atomic/atomic-long.h
> +   :internal:
> +

Why not add

  .. kernel-doc:: include/linux/atomic/atomic-instrumented.h
     :internal:

as well ??

I think those kernel-doc comments are the most relevant ones
for driver writers.

        Thanks, Akira

>  Kernel objects manipulation
>  ---------------------------
>  
