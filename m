Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1687DE648
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 20:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjKATNH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjKATNG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 15:13:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D9A2;
        Wed,  1 Nov 2023 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aOxi51YH1v/j/EjAwpYLjGYkjIinbzkIxdgV5FAKI4Y=; b=WiEoVg5PNV6trJEHAP57v4vapE
        HsiW/WaZ1ywph9RexV0ygy2ZNrDMriWecYuLgXXGjhgj5ea8iXbze4mpWGJ8D41YGwCm2AuITpkmA
        dXf1k2mIT1kA5v98uqJ3rZ0VYbcZFfJTzjrlZCKsim3z0E2GpPRfmfrABWdlLG2y5HR80EX3O1/n/
        0VhCE43Q/f/EotzJFbGu3M1OZX/hiYAQXqB1T41syyxv8F4vOgZpMvjrUm7lnjkULJWdOZhwRlsKO
        b2L3E61WXB6xLejqKmV28FFWDjsF0fx84eEJCvQZWCJlh/UNFGXs/43jy2bnPjHs6w4Iim08mtZCI
        ERZ/FrPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyGe4-0080C0-0r;
        Wed, 01 Nov 2023 19:12:52 +0000
Date:   Wed, 1 Nov 2023 12:12:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 1/1] kernel/config: Introduce
 CONFIG_DEBUG_INFO_IKCONFIG
Message-ID: <ZUKjNJBoglBdRJbg@bombadil.infradead.org>
References: <20231027171756.1241002-1-stephen.s.brennan@oracle.com>
 <20231027171756.1241002-2-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027171756.1241002-2-stephen.s.brennan@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 27, 2023 at 10:17:56AM -0700, Stephen Brennan wrote:
> The option CONFIG_IKCONFIG allows the gzip compressed kernel
> configuration to be included into vmlinux or a module. In these cases,
> debuggers can access the config data and use it to adjust their behavior
> according to the configuration. However, distributions rarely enable
> this, likely because it uses a fair bit of kernel memory which cannot be
> swapped out.
> 
> This means that in practice, the kernel configuration is rarely
> available to debuggers.
> 
> So, introduce an alternative, CONFIG_DEBUG_INFO_IKCONFIG. This strategy,
> which is only available if IKCONFIG is not already built-in, adds a
> section ".debug_linux_ikconfig", to the vmlinux ELF. It will be stripped
> out of the final images, but will remain in the debuginfo files. So
> debuggers which rely on vmlinux debuginfo can have access to the kernel
> configuration, without incurring a cost to the kernel at runtime.
> 
> The configuration is enabled whenever DEBUG_INFO=y and IKCONFIG!=y. The
> added section is not large compared to debug info sizes. It won't affect
> the runtime kernel at all, and this default will ensure that
> distributions intending to create useful debuginfo will get this new
> addition for kernel debuggers.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Although this begs to support something other than old gz in the future.

  Luis
