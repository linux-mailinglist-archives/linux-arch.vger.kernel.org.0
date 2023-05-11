Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D96FEEDD
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjEKJbI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbjEKJbH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 05:31:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4884EEC;
        Thu, 11 May 2023 02:31:06 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-757741ca000so500431385a.2;
        Thu, 11 May 2023 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683797466; x=1686389466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44LgLHJDIULJkMBem069KICIq3uxO214CaUgM8dXQT8=;
        b=BDA3XAW6HVHBBCTylbjq0CrSvwep3z/RKHIin6eHkOxIgxSvF9oCpp4JdMxjhKCg8a
         t6De61RAZB8nwhqVhhnd+GwGOl5A9f6x8ta1mhnXQNHIA8XVVWTsZ3z2sLNVKJGzzpnv
         pVJ84YIgNXNe3zzg0Bt2DTwq5JDGQGStI/fGod4pqnCGfyQ7QKofa8hYUqI7j01kYIh5
         pdBpovGUxFwqp+4kZG7VlWddqhNwbB9KXu5x5m7XiaxjuDvLIgeFm1gLHxbutaTsEe0t
         4R0BYZnEDMzRXc8veBcbo5PxiVrNC+0sZriJIWCU7Z1JN7IWfsEaHn66MIjE5tmEuP4w
         GExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797466; x=1686389466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44LgLHJDIULJkMBem069KICIq3uxO214CaUgM8dXQT8=;
        b=dOB9EqJRKU9yOdD/XZ2T/hNNSCFQtAGKxLUU16T6mVKz6TCWCNalINroxiiD+sbp+Q
         N406tuWlnXrlHLE2XghdpM1R3uUH36/6YyhUpY3pcf530A7VBgwc1oc16edXX3Ev6GXs
         LBNQKqX1qhl2XbgpqAYRY9CZ87xGR7xBkKEcvVQw3uWauWfGtzjMRZV4IMh71TRci4jH
         SFrooGCERFq2zkzbvwiIg/zPCHBSsLTZ1IZ/vFfLCZyAEVJcl917xswax7omKu2TB8gr
         Eh7yq94a71+WRcFrOC+k7GuokGZbJbvPS8EGTWotP4K3o7XyytgSr1KhNmmjNqyFGvI7
         Wfrg==
X-Gm-Message-State: AC+VfDzWHForSBQse/Glxvyj0A7Qwsifs7e0vqzajeOPLXEXBtCnBeU2
        uMOe012FZ5yNduh3m9Uq3zTkdCRCOOUnWZCK5tk=
X-Google-Smtp-Source: ACHHUZ4gCIyUNhd/+bbAhcP9wNcKpLhKmfok0Ws6ilq/cfwGVAdfDhZw6m7PSHSI2kufFJi8oJq2AHQm2PPca7W1ngo=
X-Received: by 2002:ad4:5961:0:b0:621:4551:c6dc with SMTP id
 eq1-20020ad45961000000b006214551c6dcmr7378789qvb.39.1683797465598; Thu, 11
 May 2023 02:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230510195806.2902878-1-nphamcs@gmail.com> <0d8e2503-5d4f-4b60-84ff-01a23bcf557f@app.fastmail.com>
In-Reply-To: <0d8e2503-5d4f-4b60-84ff-01a23bcf557f@app.fastmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 11 May 2023 02:30:54 -0700
Message-ID: <CAKEwX=OFVkc2GL3jmoC-qAuwZvzxfs7v__aWY=8bLY3MeMq9hA@mail.gmail.com>
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kernel-team@meta.com,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>, chris@zankel.net,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 11, 2023 at 12:05=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Wed, May 10, 2023, at 21:58, Nhat Pham wrote:
> > cachestat is previously only wired in for x86 (and architectures using
> > the generic unistd.h table):
> >
> > https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com=
/
> >
> > This patch wires cachestat in for all the other architectures.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> The changes you did here look good, but you missed one
> file that has never been converted to the syscall.tbl format:
> arch/arm64/include/asm/unistd32.h along with the __NR_compat_syscalls
> definition in arch/arm64/include/asm/unistd.h, please add those
> as well, and then
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Just sent a follow-up fixlet for this:

https://lore.kernel.org/linux-mm/20230511092843.3896327-1-nphamcs@gmail.com=
/T/#u

Thanks for the suggestion!
