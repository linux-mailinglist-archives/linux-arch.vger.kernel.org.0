Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099BB21F8D8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGNSO0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 14:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGNSO0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 14:14:26 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6A2225AA;
        Tue, 14 Jul 2020 18:14:18 +0000 (UTC)
Date:   Tue, 14 Jul 2020 19:14:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     zong.li@sifive.com, linux-riscv@lists.infradead.org,
        rppt@linux.ibm.com, linux@armlinux.org.uk, will@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, gxt@pku.edu.cn,
        Arnd Bergmann <arnd@arndb.de>, linus.walleij@linaro.org,
        akpm@linux-foundation.org, mchehab+samsung@kernel.org,
        gregory.0xf0@gmail.com, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com, steve@sk2.org, tglx@linutronix.de,
        keescook@chromium.org, alex@ghiti.fr, mcgrof@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        alex.shi@linux.alibaba.com, andriy.shevchenko@linux.intel.com,
        broonie@kernel.org, rdunlap@infradead.org, davem@davemloft.net,
        rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org,
        krzk@kernel.org, zaslonko@linux.ibm.com,
        matti.vaittinen@fi.rohmeurope.com, uwe@kleine-koenig.org,
        clabbe@baylibre.com, changbin.du@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, glider@google.com,
        elver@google.com, davidgow@google.com, ardb@kernel.org,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v2 4/5] arm64: Use the generic devmem_is_allowed()
Message-ID: <20200714181415.GC10736@gaia>
References: <20200709211925.1926557-1-palmer@dabbelt.com>
 <20200709211925.1926557-5-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709211925.1926557-5-palmer@dabbelt.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 02:19:24PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> I recently copied this into lib/ for use by the RISC-V port.
> 
> [I haven't even build tested this.  The lib/ patch is on riscv/for-next,
> which I'm targeting for 5.9, so this won't work alone.  See the cover
> letter for more details.]
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
