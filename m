Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694D34D5F12
	for <lists+linux-arch@lfdr.de>; Fri, 11 Mar 2022 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbiCKKEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Mar 2022 05:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiCKKEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2022 05:04:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F2151D19;
        Fri, 11 Mar 2022 02:03:45 -0800 (PST)
Received: from zn.tnic (p200300ea9719388a4988cf4d8129e469.dip0.t-ipconnect.de [IPv6:2003:ea:9719:388a:4988:cf4d:8129:e469])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DCB01EC02DD;
        Fri, 11 Mar 2022 11:03:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646993019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OUaGFHp5NKVe5CJxdIfOHD2DfGuKxPuZDH1EuX/Bg7c=;
        b=coGnfFSEJZLXZjFG3kj9PChLAyiTWAqvojdKLNOzywngKhEAYepgoyd/pwLA9YyOoSdNmJ
        axkLi0rXa2SG6A28BZ/5SH6a4NPXmzJWGcjXRiUZAYwzGjvugLcq/wowQHhP7h1VBSffBv
        oF/ommKcvdUlX5m76cTJ6wq/ToBSaok=
Date:   Fri, 11 Mar 2022 11:03:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Cree <mcree@orcon.net.nz>, linux-arch@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YisegQyTNi02Iq4s@zn.tnic>
References: <YeCuNapJLK4M5sat@zn.tnic>
 <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic>
 <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic>
 <YeKyBP5rac8sVvWw@zn.tnic>
 <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
 <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
 <164686349541.391760.11942525130947458475.b4-ty@chromium.org>
 <87czit4cae.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87czit4cae.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 10, 2022 at 05:29:13PM -0600, Eric W. Biederman wrote:
> Kees can you pick this one up in for-next/execve as well?

I can carry it through tip, no probs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
