Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA951600A91
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 11:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJQJ0T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJQJ0P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 05:26:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D672C5FE8;
        Mon, 17 Oct 2022 02:26:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665998216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7swWc8TIb0pOO0AKR90hlMudtPadg541PznsCr815/4=;
        b=kS3F0nHPvD12tlkD9+ua7cIftv2y+VsPR8VyT2otjXhmUPNZjy8Fua14Yk8JuHsHLKKoOU
        UbaOCB2lX/JvP76ILERHBj+YNfS3lg23FMq6mEoGUAlljxylmdvQjVM3ikRWm7QsvJGIZF
        uKVby9soEkLy3r/uhAD7kf3TPva7DllzMrlxPtJF+5BmMOpdY/MXc+iUuSNDeuD1LJYf0E
        KNabZkI6CuYzIkW6FQdv71XjNqsd9DOORL5YfxuaRTu0tG9xOPkN5f976KkhSKyVDCgw7D
        Ge/emUT7QZ8rWQl1ZayiIUG/nfLSOcshOqsTug1ZkpeeMhHpQEsI02JebAoa7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665998216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7swWc8TIb0pOO0AKR90hlMudtPadg541PznsCr815/4=;
        b=lAQYHkEGXv3OyTwDmgAe6oQKu/HIJNaHYA8Wbg720eLHKHTdo0TGAejjiOIx3eeei2rj6d
        dgehm9fx5yvoyEBw==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, x86@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 7/9] x86: Remove CONFIG_ARCH_NR_GPIO
In-Reply-To: <f118e911b3b61202a71ec5832b71a1738fb37350.1662116601.git.christophe.leroy@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <f118e911b3b61202a71ec5832b71a1738fb37350.1662116601.git.christophe.leroy@csgroup.eu>
Date:   Mon, 17 Oct 2022 11:16:56 +0200
Message-ID: <875ygirerb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 02 2022 at 14:42, Christophe Leroy wrote:
> CONFIG_ARCH_NR_GPIO is not used anymore, remove it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
