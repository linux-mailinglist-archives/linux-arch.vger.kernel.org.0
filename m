Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D6E66297D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbjAIPMQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 10:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbjAIPL2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 10:11:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7581FF02A;
        Mon,  9 Jan 2023 07:11:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c26so1905272pfp.10;
        Mon, 09 Jan 2023 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbMyQ+Lk6XMV45ZxQEld3vGI2Hm83HoIjGeiP+5YohY=;
        b=UiyJWV8IESgIQ+htn089mbpQcf/DLM9JuIZW92t4SLyj7AJACTqzJqRhhioRc+Z08O
         ffJigl+z8xYM/epYBQLukDEyeOtTH1tM7SAJbR7WOX7BbZ/FrxXl23ilCtw/lhtOVpeF
         pQDilsaYeJlxPdgOuB2kpOB9N/22VjmvkMgJj3N35N3ajCe35g+vg/lIrj2unu/Evrpx
         fU2zQ9eqCPlN/nNvTZOa47ifIE3siIIOYkbW9vsA3YVH85KM6Oa4xBeI6OXmCZpoM9i2
         b5kAMbdtBNPmjzzxKBYfzZUeGVBUUWf0ZNBmFg9UICKxIcyhk5OqehRsRS1GdlmX7Sb4
         De4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbMyQ+Lk6XMV45ZxQEld3vGI2Hm83HoIjGeiP+5YohY=;
        b=0Og63mnKnkLCjRttBZPdyN8VozjcRU0av3C0wx3bjU6vCL2kVOoAStZzPihJIktF9T
         5nz9MKJFbzgHBVbl5ap3ff/fDyOf9six3gAeST+wS3Uo7w0GPnwQJRisZ/VfGTZ2/nIR
         PV2lKB1l2+vPKGhMG6L3DsQADW1EmQpq7X84fnFazjrdFkZN9UujT7ZT4V+MbqJwG4Qq
         7RHGhnpWrQOfGwYjgc42PVXfK7SP8DH4pG5YUTr0ZPdvZrrOG2iUhs3M4iV71cyMB30x
         6+OEnxnlMHHTHpox/VRribSl0Wk+OxFsnYAXJ1ppTKPqen92EVXPIeXFAAmgf7aZA+JE
         ZH3g==
X-Gm-Message-State: AFqh2kpLebFNqVZUXPo/k2iJ3wOv+5LEkc0I2s6t7oI2cUOGtdRhHa8z
        uI4aBLVclZKIhDYuAkZLBvLf8mFmvJYKf4rgz3w=
X-Google-Smtp-Source: AMrXdXtaMXZw+A+awBZWMsLxBBg2VbK1BTjUoNNl6u+Vm395uYoqWXtbYO/zcm6KlM3AUdY2y8deWO0NXh0INgA2vaA=
X-Received: by 2002:a63:f957:0:b0:477:98cc:3d01 with SMTP id
 q23-20020a63f957000000b0047798cc3d01mr3281088pgk.505.1673277078970; Mon, 09
 Jan 2023 07:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20230103164359.24347-1-ysionneau@kalray.eu> <CAEr6+ECRh_9App18zmcS6FUR81YYhR=n4kGdeZAtQBsdMB55_A@mail.gmail.com>
 <6570d22d-ee19-f8b1-6fb4-bf8865ec4142@kalray.eu>
In-Reply-To: <6570d22d-ee19-f8b1-6fb4-bf8865ec4142@kalray.eu>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 9 Jan 2023 23:11:07 +0800
Message-ID: <CAEr6+ECPFeokSULpWzYEYLROYHXNA0PtvdUchT37d4_qVA-PKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, bpf@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Eric Paris <eparis@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-audit@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Moore <paul@paul-moore.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, Alex Michon <amichon@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Jonathan Borne <jborne@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 9, 2023 at 9:21 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> Hi Jeff,
>
> On 1/7/23 07:25, Jeff Xie wrote:
> > Hi,
> >
> > On Wed, Jan 4, 2023 at 1:01 AM Yann Sionneau <ysionneau@kalray.eu> wrot=
e:
> >> [snip]
> >>
> >> A kvx toolchain can be built using:
> >> # install dependencies: texinfo bison flex libgmp-dev libmpc-dev libmp=
fr-dev
> >> $ git clone https://github.com/kalray/build-scripts
> >> $ cd build-scripts
> >> $ source last.refs
> >> $ ./build-kvx-xgcc.sh output
> > I would like to build the kvx-xgcc to compile and test the linux
> > kernel, but it reported a compile error.
> > I wonder what version of gcc you are using.
> >
> > My build environment:
> > VERSION=3D"20.04.2 LTS (Focal Fossa)"
> > gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
> >
> >
> > Compile error:
> > $ ./build-kvx-xgcc.sh output
> >
> > ../../binutils/libiberty/fibheap.c: In function =E2=80=98fibheap_replac=
e_key_data=E2=80=99:
> > ../../binutils/libiberty/fibheap.c:38:24: error: =E2=80=98LONG_MIN=E2=
=80=99 undeclared
> > (first use in this function)
> >     38 | #define FIBHEAPKEY_MIN LONG_MIN
> >        |                        ^~~~~~~~
> > [snip]
>
> What SHA1 of https://github.com/kalray/build-scripts are you using?

I have executed the "source last.refs"

> We are building our toolchain on Ubuntu 18.04 / 20.04 and 22.04 without
> issues, I don't understand why it does not work for you, although indeed
> the error log you are having pops out on my search engine and seems to
> be some well known issue.

Yes, there are many answers on the web, but none of them solve this problem=
.

> If the build-script does not work for you, you can still use the
> pre-built toolchains generated by the GitHub automated actions:
> https://github.com/kalray/build-scripts/releases/tag/v4.11.1 ("latest"
> means 22.04)

Thanks, this is the final solution ;-)

>
> I hope it will work for you.
>
> Regards,
>
> --
>
> Yann
>
>
>
>
>


--=20
Thanks,
JeffXie
