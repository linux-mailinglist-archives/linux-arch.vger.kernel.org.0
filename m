Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75388508DC1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiDTQyO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiDTQyM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 12:54:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D13E0CD
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:51:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x80so2494696pfc.1
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=75aEtLVVskQwplfG1XbK/PPMy44vZPZUgB+8LUXq4M4=;
        b=emgn1y9ywqnwNFhPxR5f9njVHoOQc9+qc35Oi3HPEEzdMfTlNOeJ/8jtrkZBju1aKc
         AEFLNWFZF8+qXlNuivoviaxx9csH51ZGvDQzblwjNCWNStS0GS/9RPIEMoHu9M+O+2aj
         +jW8hz60xNIh4GsXUOSMyyhnw/VMa9F/pN/oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=75aEtLVVskQwplfG1XbK/PPMy44vZPZUgB+8LUXq4M4=;
        b=n68JCP3QHbcKtiGspbuoCNLFN+oj6Tix9oOHLYyxlqlzTgmOtIc2DXlF1hEvLoy6Dr
         mM9/+SxkDTwO7Pbq3ssEKGvsJSBIYzvS6nPX5ifossBclW7vYatLX6G3QDxIXDCYfnWb
         sT3ufKMlm+Eq/r26acIZFi9VyRgpkMfpfvSvabTQfSeWD21j47Zv+1zuOHXVKZrtWw1P
         CzquPdTtDO+0KYhEIOUbUU9XgARuD6gmmZ6nKmgMlKKmItG/l5ZSFcFV09aruT3IBui3
         ntEMxdimoqQZxWQnIAUCASqdVVJU3ebWYtl/MW7OXyQS3kWwtyWNqslWMTkkOnin9F4O
         yjPA==
X-Gm-Message-State: AOAM531euiUWcStvCNoKBJviL3gg+mBlkwJrQsgP+TdGua9QdGCkVkw7
        QMrRttVbhTWkPgu5OoUXJTrCHg==
X-Google-Smtp-Source: ABdhPJwBhq5nUAt/GWX1jJoxxnvjt8PlAWyO9xz4E4dpr0gW4ecUCqHufOp+thKUgWbRKKCVCUg1ow==
X-Received: by 2002:a63:6c8a:0:b0:398:5208:220a with SMTP id h132-20020a636c8a000000b003985208220amr20113824pgc.176.1650473485783;
        Wed, 20 Apr 2022 09:51:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r32-20020a17090a43a300b001cdbda883ccsm278919pjg.38.2022.04.20.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:51:25 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:51:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v13 1/2] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <202204200951.24D7A5A24@keescook>
References: <20220419105156.347168-1-broonie@kernel.org>
 <20220419105156.347168-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419105156.347168-2-broonie@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 19, 2022 at 11:51:55AM +0100, Mark Brown wrote:
> Currently the ELF code only attempts to parse properties on the image
> that will start execution, either the interpreter or for statically linked
> executables the main executable. The expectation is that any property
> handling for the main executable will be done by the interpreter. This is
> a bit inconsistent since we do map the executable and is causing problems
> for the arm64 BTI support when used in conjunction with systemd's use of
> seccomp to implement MemoryDenyWriteExecute which stops the dynamic linker
> adjusting the permissions of executable segments.
> 
> Allow architectures to handle properties for both the dynamic linker and
> main executable, adjusting arch_parse_elf_properties() to have a new
> flag is_interp flag as with arch_elf_adjust_prot() and calling it for
> both the main executable and any intepreter.
> 
> The user of this code, arm64, is adapted to ensure that there is no
> functional change.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
