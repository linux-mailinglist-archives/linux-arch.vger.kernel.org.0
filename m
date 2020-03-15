Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15B185F09
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgCOSaw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Mar 2020 14:30:52 -0400
Received: from foss.arm.com ([217.140.110.172]:34566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgCOSaw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 15 Mar 2020 14:30:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CE31FB;
        Sun, 15 Mar 2020 11:30:51 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF083F67D;
        Sun, 15 Mar 2020 11:30:48 -0700 (PDT)
Date:   Sun, 15 Mar 2020 18:30:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 20/26] arm64: vdso32: Include common headers in the
 vdso library
Message-ID: <20200315183041.GD32205@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-21-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313154345.56760-21-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 13, 2020 at 03:43:39PM +0000, Vincenzo Frascino wrote:
> The vDSO library should only include the necessary headers required for
> a userspace library (UAPI and a minimal set of kernel headers). To make
> this possible it is necessary to isolate from the kernel headers the
> common parts that are strictly necessary to build the library.
> 
> Refactor the vdso32 implementation to include common headers.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
