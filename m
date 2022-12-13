Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6D64BB31
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 18:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiLMRjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 12:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiLMRjv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 12:39:51 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6FBE0B
        for <linux-arch@vger.kernel.org>; Tue, 13 Dec 2022 09:39:50 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m4so551862pls.4
        for <linux-arch@vger.kernel.org>; Tue, 13 Dec 2022 09:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22ObQGxg+tFUaeC+8ZZZyuwT6ARH/aXdjVJKbHdOy44=;
        b=URZsnF5wMVvtSu7sYKk1PLkEIeFVIi7BWgYDjhE1LUeEL67l0ur1pafnT7b4yE0N/t
         +KpU+8OBbftjRfDvLYMCXqJDGeBssIpZo10KsrzjRQoXFQOya0NMF+LD2j8AMrUJrzW/
         ve/E+3HjTFyawNdVDvfRf8XGe0v4CZtV8GRgIgCg1zlZWHfEFlVgEsX7Pct5C6a5wwJ4
         bxomtJD/zLE7AFdWuRPg9oVZr36WsZJxXWFabR1xK0iWqmnqh/wZHCYbxbl1CnHgdQJU
         /X6a8hruLn3TxDjh6tEFVWnqP0doCZD7VCopFnvA93Elx/4jGDdLCMCp3gTd/MfiaGBX
         6/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22ObQGxg+tFUaeC+8ZZZyuwT6ARH/aXdjVJKbHdOy44=;
        b=txoNb7daBE6Hbwc1bdcPHo10i5lgiCsTzxhuxnuNrIuB5/wvzdrpcQ7J1rAhXYy3Ct
         IHNjpRYTNfrE3ZVHfqrRDt7ejTehHK6a5gaPCsovucWNMSPdK7rIeijLDB0doqcqmney
         EU7JFuxc13C2eEDgY99XOYC5UEhoz/E/HPPsdCM0vIhNT4WPcUOQgrMgFiSJQfP/O1+G
         MWxpuCe5cYxa+DaH+8TiVwBrmZFpoOBATCTN3lTOb4admNJWg3JAxG/k2osbg0+aUDET
         p6RRUXms+ku9jBesZISXeColqasEQcizbobt2cfAw1yJ28MGMXng178TQxyaxwAHWB0P
         4tBA==
X-Gm-Message-State: ANoB5pl0P91oXIaiHyNyKkh3xHa4W8ankbvhNQ2UY40SjWMhyG3OJ587
        9dyVRdguwlju4CqsRMJ4ZfLt2Q==
X-Google-Smtp-Source: AA0mqf5To8as2YcpcxnoSETfteJYs1LY13fx/hUL7Wn1CurlZTVGERzkFiFuTf8kp3UXKidYBcf8dQ==
X-Received: by 2002:a05:6a20:549e:b0:a3:218a:c761 with SMTP id i30-20020a056a20549e00b000a3218ac761mr31611098pzk.5.1670953190283;
        Tue, 13 Dec 2022 09:39:50 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id l5-20020a639845000000b004767bc37e03sm7100779pgo.39.2022.12.13.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:39:49 -0800 (PST)
In-Reply-To: <20221207091112.2258674-1-guoren@kernel.org>
References: <20221207091112.2258674-1-guoren@kernel.org>
Subject: Re: [PATCH] riscv: Fixup compile error with !MMU
Message-Id: <167095316650.17956.4201047992243402866.b4-ty@rivosinc.com>
Date:   Tue, 13 Dec 2022 09:39:26 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Conor Dooley <conor@kernel.org>, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        lizhengyu3@huawei.com, liaochang1@huawei.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 7 Dec 2022 04:11:12 -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Current nommu_virt_defconfig can't compile:
> 
> In file included from
> arch/riscv/kernel/crash_core.c:3:
> arch/riscv/kernel/crash_core.c:
> In function 'arch_crash_save_vmcoreinfo':
> arch/riscv/kernel/crash_core.c:8:27:
> error: 'VA_BITS' undeclared (first use in this function)
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> 
> [...]

Applied, thanks!

[1/1] riscv: Fixup compile error with !MMU
      https://git.kernel.org/palmer/c/c528ef0888b7

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
