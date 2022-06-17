Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22A254F4A5
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 11:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381385AbiFQJvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381174AbiFQJvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 05:51:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE4692A4;
        Fri, 17 Jun 2022 02:51:43 -0700 (PDT)
Date:   Fri, 17 Jun 2022 11:51:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655459500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bibq7Q6QM7w+swDPtmlvZ3luRS+p/L2t/kOLJ5BkOk4=;
        b=VsQuETL6Zs1I7YQO+CiAH4cbNMsgnzIQrW06+38+snWb8jfBz2YBeJtXUHT6AEGEhswftS
        wPCXv4xNcLlzWgoGB0o5n3z9z72l0ez4ICsJwsWQunt7SDFsFEddJkcJfVLNv+qlcQY9BS
        yLhmPyn0z/5Hev6M3UCnxv2Mvub/3U+wljyX41d8tACULcjyDp47osWVJhNm2nV57vgswx
        xjf4FZ+0q4/kh991jULqc+UGbsJ5SHjX9Msk8lNZd4GhuSV/ZXjlAktU0ZxmiAA8VmTTZd
        akAlE6539ghv041rCCcLFe7sRuK9aE7yiAfjCeo3+L7uIqbojUfjVz/7PLPAbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655459500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bibq7Q6QM7w+swDPtmlvZ3luRS+p/L2t/kOLJ5BkOk4=;
        b=wQtx51djjoHimkvi3J2kc2u/aAGBNRk/jz74DKLWGZni8doppvPCweO8zYHH/+0sc2vlY4
        JbRtDWdHqqokFBCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] arch/*: Disable softirq stacks on PREEMPT_RT.
Message-ID: <YqxOqsgCFgGuzvnr@linutronix.de>
References: <YqjQ5kso7czrmYPW@linutronix.de>
 <YqmC1aAm+O7RD2IH@infradead.org>
 <CAK8P3a1QmeAscV-Ory-Dae4RoLvDSPEjEgFGQHR9U8jUervGuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1QmeAscV-Ory-Dae4RoLvDSPEjEgFGQHR9U8jUervGuA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-15 17:41:45 [+0200], Arnd Bergmann wrote:
> Applied to the asm-generic tree with the above fixup, thanks!

Thank you Arnd.

>       Arnd

Sebastian
