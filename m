Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2841113B39E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgANUa4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 15:30:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38616 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgANUa4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 15:30:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so13485597qki.5
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=GM2cmKJLGIw00BnTkj1dcmxxtlMk1WYpnp+HW9nEczc=;
        b=qfNdLg3kkuNI6cLLk03N289br06VFc6cqXJqoyJLg1KprL1vXCIrhjDgtVLFvs1Lwb
         AGCRxsxBhq8RqUyn380ItGPioew6bRYplCRy7vK2et+jGpulMqjnLkOTPeNz/33eXrDq
         0vFaoz7vDSh5K80ynQpMr5rMy8tA7f6nYDRq/e+wt1l6rr9+6nNEBxx8MmmB3Qm7R4Cl
         TNl5xvJuy5W6ApqyVP/ggRMHAYLrtnXI4E8Xv7pyFWREaYmrxqRLCzpVXVmBV7MZyEXE
         U3rJZrXfsMTvsHDdbHIlb8doOnexZCFIYMkSwEi0SRMSCJOxOWAm5Dg1RaK67s/foSTo
         ZGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GM2cmKJLGIw00BnTkj1dcmxxtlMk1WYpnp+HW9nEczc=;
        b=lzozD7YJdBJTAw9ypFyNB8n5uT2OvHYPmS6XtbbQCbjSSpzIfzS7VwV7icXh6/wgYi
         D3bUFPb4utRnYBFZGVPDpJNV85AFW2mh2h1JbRLJnhUnc6WSKGfz3TSPdG4hwOs/cnxJ
         VR4YPmB/dzqw+IsONV9GjI3uPnJWHZ7cLWWBIXJAZ/TR36FryfIl+hPd7LSTjFEDfx2x
         RT4AVawRwZGCd36ILrR8LNi+/GlUN2KIKDq8Lar3/CG05Riz/hkRCIHgUxW4x7gJnGLK
         /tP/N9Vjri2wBgQOdlk/WVyDeueGM44XuK65VHIuc2LaX8lTP8fYwMiYpi7y96676Uq4
         CAMQ==
X-Gm-Message-State: APjAAAW2QZGHkk3oYyVpUjFj8pWLXnkUPmyOCSO+BfHK9X+znXT+5COY
        HjBJpRpuh8XtQ0kv3mtud4koOw==
X-Google-Smtp-Source: APXvYqySWPhc8cNWPW6ZR1czJUmUILrXAmHD502QnwiMjSkfcnjRHGogwSncB5M2bJhCbEL2kLY/AQ==
X-Received: by 2002:ae9:c104:: with SMTP id z4mr18665764qki.418.1579033855079;
        Tue, 14 Jan 2020 12:30:55 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 68sm7357546qkj.102.2020.01.14.12.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 12:30:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Date:   Tue, 14 Jan 2020 15:30:53 -0500
Message-Id: <F185919B-2D86-43B6-9BEC-D14D72871A58@lca.pw>
References: <20200114192220.GS2935@paulmck-ThinkPad-P72>
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
In-Reply-To: <20200114192220.GS2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 14, 2020, at 2:22 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> Just so I understand...  Does this problem happen even in CONFIG_KCSAN=3Dn=

> kernels?

No.

>=20
> I have been running extensive CONFIG_KSCAN=3Dy rcutorture tests for quite
> awhile now, so even if this only happens for CONFIG_KSCAN=3Dy, it is not
> like it affects everyone.
>=20
> Yes, it should be fixed, and Marco does have a patch on the way.

The concern is really about setting KSCAN=3Dy in a distro debug kernel where=
 it has other debug options. I=E2=80=99ll try to dig into more of those issu=
es in the next few days.=
