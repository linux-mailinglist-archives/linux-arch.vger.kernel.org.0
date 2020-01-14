Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2213B4B1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANVss (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:48:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46489 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgANVsZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:48:25 -0500
Received: by mail-qk1-f196.google.com with SMTP id r14so13678368qke.13
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+DWS+MFZkVa3i7JL1v23vFX8ZF9bOD40hjVh+TnhgTw=;
        b=kTA/4UdOngvSeVJIgyUwXfSmC4pFX4cZ5I+ptvKNiDUDrBCK3Xa6fArbNyo6l6nxb8
         5EcYmRd0FDGFqPu64+AjMXSBJYT9Xm9K2GVc0Eibfs/aG/5+2uYGo3hERmgxzy/NrqnL
         ysJwZdrzM5vZ+w4ahgN5xLWWxN742DXjNplMMUb7Ajr9TLVEZmMDRL7jnsTO3jp11y8t
         srBKh4ZeuPiNmDR+nmaS59U+wSTXDGJ/1SXQynVkHqpCGgTBHGAhOVQi+RTdds3j9FFT
         6JE8158krmEqWBWOJJjADKiIj3cc50aC9kP/0MjE1wHc2EI3IKG9/GjmhiZNmToR8VWH
         Y4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+DWS+MFZkVa3i7JL1v23vFX8ZF9bOD40hjVh+TnhgTw=;
        b=fOK211FWDziHjvO2kZDUbpHBjuB7KAy/hDyOMM6zRyZQbUjtRob+JtbCRfrjPnxM2z
         6RVvfoY8u+ybnHwfSokc8QtluCl4YEiscn/LYqiS9HyKoTSgq5TY0j0R1pX4zWdsWSya
         nf4GY15r029hGwFmYn8G472ZRX0wtRMn8fvdBSu+3nraa9gs5u7NxpNHoCr81RYT4bEY
         7Hd2rNpxS2BtFYliL2BYoSa3d1sdtA4uZPrTXNKLoR89bKGrhke/nS2Y934A2pA7U1RL
         QSe6RFAUBflv5EkmwH0Ic440Ia2kU3guwG15x7xksUX6arMm0t+OgJxACDvHiBeO4pf8
         qG3w==
X-Gm-Message-State: APjAAAXN5tFDmZPGLYKjlrd7B7H85OZ0WJmYt6bB5bkDhMjSMw0JNcHB
        IWw1LgMBAb6WnFj/gYmWktzR8g==
X-Google-Smtp-Source: APXvYqzhz76wpbmFEdnf6KLqsZJdbwLrRAZ/QuVspYZEWhFTQ8VaAMVQ+9dwFgE6WodfNf1ikl6Q9w==
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr24178234qkk.80.1579038505028;
        Tue, 14 Jan 2020 13:48:25 -0800 (PST)
Received: from ?IPv6:2600:1000:b029:6649:f4b1:4b94:dfb9:77cf? ([2600:1000:b029:6649:f4b1:4b94:dfb9:77cf])
        by smtp.gmail.com with ESMTPSA id 24sm7408173qka.32.2020.01.14.13.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:48:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Date:   Tue, 14 Jan 2020 16:48:22 -0500
Message-Id: <9970E373-DF70-4FE4-A839-AAE641612EC5@lca.pw>
References: <20200114213405.GX2935@paulmck-ThinkPad-P72>
Cc:     Marco Elver <elver@google.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>
In-Reply-To: <20200114213405.GX2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 14, 2020, at 4:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> As an alternative, once the patches needed for your tests to pass
> reach mainline, you could announce that KCSAN was ready to be enabled
> in distros.
>=20
> Though I confess that I don't know how that works.  Is there a separate
> testing kernel binary provided by the distros in question?

I don=E2=80=99t think I have powers to announce that. Once the feature hit t=
he mainline, distro people could start to use in the debug kernel variant, a=
nd it is a shame to only find out it is broken. Anyway, I=E2=80=99ll try to e=
dge out those corner cases. Stay tuned.=
