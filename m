Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C56C87ED
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCXWBn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjCXWBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 18:01:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214C9158A3
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 15:01:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u10so3106761plz.7
        for <linux-arch@vger.kernel.org>; Fri, 24 Mar 2023 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679695300;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMXLcRgH9sF4l1frJ5KDFBQahch+t+Pfs7sWVinOqQk=;
        b=6nJasBQh6rMddp7eC89uymnike8qVmoMiN2sIBJbxj0BZypslz19zGYsgGIhibGbvG
         GjMMEgveFN8UBfak5uPmhKuaZCqd2teqFPDckoriQcTnJetHjjt5wvdu5ZvLSGKnHmUd
         qRcUqPV+5H3fJDJb5rzyd3KqRJuNThK7Hq4duKja3cofNAeJP6DDmFkJcbGFoK1rq3Ch
         qxPMs4MKhQVwBLEn+CkuDT7+gFlWSqN9Vv6M8YOULOwBqGutxublUl5r7x9pcLe+lbzu
         R7Ed8b9P0owRxWZBm2ULleoLzWPe6d0+LbNBPh9ewu6ecrFtvCtueSFd4vzdaSXHzOA5
         JHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695300;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMXLcRgH9sF4l1frJ5KDFBQahch+t+Pfs7sWVinOqQk=;
        b=B96qZgSO22wYt9Q19B22Gr1XPhFfVDCfXE2a16ZNJcAoisjtP0nUFEGirX6CGl1fn2
         nDHE8M5ZGSbQPoXJjlX9hgmEm9lRqQSYCMhB7csZIRzkzGonISRqDlxXDO3bXyGYO5sx
         CKz8pRPFAGkysgIVofRXe4RTrXLBdlDZweb+iJU4ACKUdal6WQu9vT2JVUzL5fBIccMB
         ZVMWgFdf6TRENq/zV5YRINP4MyKHwjP0zdMZ1IJenk7RZ1wyYnY0vePyGrbdvlY+0W+t
         LXb+cOQRPVCAoKAx9w2PEvOiIjOuY/b6GZAf0fZ4Eun8KMC4xSY/ucIYuj2mjOyHCAD5
         wFLw==
X-Gm-Message-State: AAQBX9cHFsb1LBqHkaXhzDjkjL/eBqZPTl1JMh+jV0OkhfTn4PySxpDN
        1U8Ulg2PHHV3VE/N9wCgCAqpgw2cFZcH+D4G0xwUFg==
X-Google-Smtp-Source: AKy350bpY6oEPwkdkkjYRycrJC7DL1aXlQymZN36kbTCUbwz4pCxJaS9/0ZF59cn59bKg1/yP3Hd7g==
X-Received: by 2002:a17:903:6c4:b0:19c:fc41:2dfd with SMTP id kj4-20020a17090306c400b0019cfc412dfdmr3283889plb.29.1679695299906;
        Fri, 24 Mar 2023 15:01:39 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902bf4700b0019a60b7cc0esm14649540pls.248.2023.03.24.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:01:39 -0700 (PDT)
In-Reply-To: <20230222033021.983168-1-guoren@kernel.org>
References: <20230222033021.983168-1-guoren@kernel.org>
Subject: Re: (subset) [PATCH -next V17 0/7] riscv: Add GENERIC_ENTRY
 support
Message-Id: <167969528245.13232.1422776002762146191.b4-ty@rivosinc.com>
Date:   Fri, 24 Mar 2023 15:01:22 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, Mark Rutland <mark.rutland@arm.com>,
        ben@decadent.org.uk, bjorn@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>, guoren@kernel.org
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Tue, 21 Feb 2023 22:30:14 -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The patches convert riscv to use the generic entry infrastructure from
> kernel/entry/*. Some optimization for entry.S with new .macro and merge
> ret_from_kernel_thread into ret_from_fork.
> 
> The 1,2 are the preparation of generic entry. 3~7 are the main part
> of generic entry.
> 
> [...]

Applied, thanks!

[2/7] riscv: ptrace: Remove duplicate operation
      https://git.kernel.org/palmer/c/8574bf8d0ddd
[3/7] riscv: entry: Add noinstr to prevent instrumentation inserted
      https://git.kernel.org/palmer/c/d0db02c62879
[4/7] riscv: entry: Convert to generic entry
      https://git.kernel.org/palmer/c/f0bddf50586d
[5/7] riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
      https://git.kernel.org/palmer/c/0bf298ad2b61
[6/7] riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
      https://git.kernel.org/palmer/c/ab9164dae273
[7/7] riscv: entry: Consolidate general regs saving/restoring
      https://git.kernel.org/palmer/c/45b32b946a97

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

