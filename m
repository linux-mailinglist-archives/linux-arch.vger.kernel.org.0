Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C355D3B08
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 10:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfJKI0b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 04:26:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:43040 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfJKI0a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 04:26:30 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9B8PNOs001341;
        Fri, 11 Oct 2019 03:25:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x9B8PJiY001329;
        Fri, 11 Oct 2019 03:25:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 11 Oct 2019 03:25:19 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-parisc@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH v2 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Message-ID: <20191011082519.GI9749@gate.crashing.org>
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-2-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011000609.29728-2-keescook@chromium.org>
User-Agent: Mutt/1.4.2.3i
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 05:05:41PM -0700, Kees Cook wrote:
> The Program Header identifiers are internal to the linker scripts. In
> preparation for moving the NOTES segment declaration into RO_DATA,
> standardize the identifier for the PT_NOTE entry to "note" as used by
> all other architectures that emit PT_NOTE.

All other archs are wrong, and "notes" is a much better name.  This
segment does not contain a single "note", but multiple "notes".


Segher
