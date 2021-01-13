Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893FF2F4F8B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 17:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbhAMQHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 11:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbhAMQHU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Jan 2021 11:07:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4969523434;
        Wed, 13 Jan 2021 16:06:37 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
Date:   Wed, 13 Jan 2021 16:06:35 +0000
Message-Id: <161055398865.21762.4907792828255955851.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210108092024.4034860-1-arnd@kernel.org>
References: <20210108092024.4034860-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 8 Jan 2021 10:19:56 +0100, Arnd Bergmann wrote:
> With UBSAN enabled and building with clang, there are occasionally
> warnings like
> 
> WARNING: modpost: vmlinux.o(.text+0xc533ec): Section mismatch in reference from the function arch_atomic64_or() to the variable .init.data:numa_nodes_parsed
> The function arch_atomic64_or() references
> the variable __initdata numa_nodes_parsed.
> This is often because arch_atomic64_or lacks a __initdata
> annotation or the annotation of numa_nodes_parsed is wrong.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: make atomic helpers __always_inline
      https://git.kernel.org/arm64/c/c35a824c3183

-- 
Catalin

