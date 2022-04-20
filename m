Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8D5080A0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 07:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351104AbiDTFgK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 01:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiDTFgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 01:36:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A25836B6A
        for <linux-arch@vger.kernel.org>; Tue, 19 Apr 2022 22:33:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so2811370pje.1
        for <linux-arch@vger.kernel.org>; Tue, 19 Apr 2022 22:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hnW6ITWz2YDcWQnTq9FpOk+73CLbsXJ06SvhUXIrkNc=;
        b=QYDHiQY3dNhb27GABAU/5GW+ECc/5koOekibJmxPB5ip6j7KOnFXo356i6Rkkk+Y0y
         4zFkMztQuIBzKS+1AiRkHsUbySJA1DT30XoEvhpV8F64jPpoCdcOQlOT/pYg4+SNAO6a
         U37u6JBkFPpdx6VVYg8yf5ml0lWSoHnGHzFpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hnW6ITWz2YDcWQnTq9FpOk+73CLbsXJ06SvhUXIrkNc=;
        b=UXkRIaFWaYP5e2Ep6QJscmDVOHkuHPcofWbCHUZUDcJ0o8FiywLSGsxteqf/uuv/30
         ANKti9Xx5No0fKIsSFFoRuW9S12eB6uZDs85z1soTMXjTtlWIyE3rOySl2K5xZ6ssAAy
         G1tI4/nqETvCh7xIvhP789Ki2N06MwPoHlNsvVCY2z5c2sHQ0vG6DzL5EEXKrvsVZTHe
         lcove/mDxs0y5kNrGdgqqEAkyL5PU8wH6r6lnWNf0imrLE/hZYnL6r+WZXcuTMqioZzR
         jBSguRuEGxW3iaClRgmBLEpfzxXfe/0BPCYH+LgztHju6co/BItDpU48/0zhiemu1ZkD
         9JcA==
X-Gm-Message-State: AOAM533erq4Hf+auKWzDXKUnCN0XhPa/8RfFVclxoY8g8e9/Pn65wUkI
        D2kyuMcX08DAsin5U3UjE6XDEA==
X-Google-Smtp-Source: ABdhPJx41LeczR669y78GNJRIV70hrjaeefY5K7srln+1SMsu01He+CrKVT95wg8yWPc6eF9mmQeTw==
X-Received: by 2002:a17:902:c40d:b0:15a:2d52:7900 with SMTP id k13-20020a170902c40d00b0015a2d527900mr1457170plk.99.1650432800101;
        Tue, 19 Apr 2022 22:33:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ml1-20020a17090b360100b001cd40539cd9sm17636859pjb.1.2022.04.19.22.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 22:33:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     will@kernel.org, broonie@kernel.org, catalin.marinas@arm.com
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        szabolcs.nagy@arm.com, yu-cheng.yu@intel.com,
        ebiederm@xmission.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as the interpreter
Date:   Tue, 19 Apr 2022 22:33:06 -0700
Message-Id: <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419105156.347168-1-broonie@kernel.org>
References: <20220419105156.347168-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 19 Apr 2022 11:51:54 +0100, Mark Brown wrote:
> Deployments of BTI on arm64 have run into issues interacting with
> systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> linked executables the kernel will only handle architecture specific
> properties like BTI for the interpreter, the expectation is that the
> interpreter will then handle any properties on the main executable.
> For BTI this means remapping the executable segments PROT_EXEC |
> PROT_BTI.
> 
> [...]

Applied to for-next/execve, thanks!

[1/2] elf: Allow architectures to parse properties on the main executable
      https://git.kernel.org/kees/c/b2f2553c8e89
[2/2] arm64: Enable BTI for main executable as well as the interpreter
      https://git.kernel.org/kees/c/b65c760600e2

-- 
Kees Cook

