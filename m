Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B382662A92
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 16:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjAIPx4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 10:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAIPxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 10:53:48 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0910F4;
        Mon,  9 Jan 2023 07:53:48 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g68so5060926pgc.11;
        Mon, 09 Jan 2023 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr5NMyR17w820E39Zxy+TJT5WIxXv3t9mTGHg5DI4M8=;
        b=p925wfq85MYYr0Q3szQHiqh8M9TGBDNLmFWeMdVCKRfm+cOHibl08yqwJoSo2r7XJP
         wq9Jltk/+brtH8hNCZXvq0DxtwSQIazxtjZdEKfg/0vGYUECRtOKJhbchra23Qxq01EI
         LW2KfmroEgha10Hiqqq7sbs4sKftMAXbHM5UfrApMgHovRtAjqup/7ZDx5c66hJHq9Cr
         iYTmJQehTgnexoKO7TcMDfBVxLmHJagL/RtulJH5m9HvVCQxeaP/W6dGAdxxBRvcFDn6
         /uu4CaMMaHvzdo/E1y8HoopqpLRDOCKFzxs2QxX+RtbfC5zpKXwCLbC6QNQfLNGjuHM5
         8s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr5NMyR17w820E39Zxy+TJT5WIxXv3t9mTGHg5DI4M8=;
        b=vsVUyyhZaXC1xZa0W/BkpO28agq8dxXdBLZwJdYz8+hOKSGPkePAbr+IXJer1xGS/x
         vIa08qKS+TyQTvnM8R3uG7GqRUPS+6gIzWiLrfTPFdU1WcAyl9kU3Wh9FZIAZu+JzHzo
         dVDzK3utkV+zj8y4iS+c8obaR64okqEHZYm9NISdKQEpy6YKMkdAI+Cfpz/9CTWrBPPO
         cHHwE8mEkKTaODrCdOYUxzxx42uPAUFQlKe2+YOAszc9LCC20yEsMue6PEAGX3IoZ+MY
         nBf7hl7rmNfCFfEvDMqMo6ELbsXW4MZmF1edhQREXln6fDUnnTaF/FcFprn42l1vkL5i
         adrg==
X-Gm-Message-State: AFqh2kr93MOknIB1o+1etlr9ym9CmzXNP1B0/FZCyO0i3FGNkIZXOEsT
        q7dmOOQoczYQQb/o/KO9Kk0o5oFyY6CcOaZRa+0=
X-Google-Smtp-Source: AMrXdXu5iAQa5w4G/nXooBZotH/u8Cle9aRMcHOGEDe3ZcG1lDUD8XzrRE/n7dp+CGJamrwD1EZHy0OvHYQNsDsudys=
X-Received: by 2002:a63:1e42:0:b0:478:9503:f498 with SMTP id
 p2-20020a631e42000000b004789503f498mr3557980pgm.96.1673279627421; Mon, 09 Jan
 2023 07:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20230103164359.24347-1-ysionneau@kalray.eu> <CAEr6+ECRh_9App18zmcS6FUR81YYhR=n4kGdeZAtQBsdMB55_A@mail.gmail.com>
 <6570d22d-ee19-f8b1-6fb4-bf8865ec4142@kalray.eu> <CAEr6+ECPFeokSULpWzYEYLROYHXNA0PtvdUchT37d4_qVA-PKQ@mail.gmail.com>
 <bccad498-3af2-08f1-8264-cf7b438732d3@kalray.eu>
In-Reply-To: <bccad498-3af2-08f1-8264-cf7b438732d3@kalray.eu>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 9 Jan 2023 23:53:35 +0800
Message-ID: <CAEr6+EC0SCXLrQ2YNYyCyMK1Z9=3=ajbbLP+RKSsARGsmJO9YA@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 11:30 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> Hi Jeff,
>
> On 1/9/23 16:11, Jeff Xie wrote:
> > On Mon, Jan 9, 2023 at 9:21 PM Yann Sionneau <ysionneau@kalray.eu> wrot=
e:
> >> Hi Jeff,
> >>
> >> On 1/7/23 07:25, Jeff Xie wrote:
> >>> Hi,
> >>>
> >>> On Wed, Jan 4, 2023 at 1:01 AM Yann Sionneau <ysionneau@kalray.eu> wr=
ote:
> >>>> [snip]
> >>>>
> >>>> A kvx toolchain can be built using:
> >>>> # install dependencies: texinfo bison flex libgmp-dev libmpc-dev lib=
mpfr-dev
> >>>> $ git clone https://github.com/kalray/build-scripts
> >>>> $ cd build-scripts
> >>>> $ source last.refs
> >>>> $ ./build-kvx-xgcc.sh output
> >>> I would like to build the kvx-xgcc to compile and test the linux
> >>> kernel, but it reported a compile error.
> >>> I wonder what version of gcc you are using.
> >>>
> >>> My build environment:
> >>> VERSION=3D"20.04.2 LTS (Focal Fossa)"
> >>> gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
> >>>
> >>>
> >>> Compile error:
> >>> $ ./build-kvx-xgcc.sh output
> >>>
> >>> ../../binutils/libiberty/fibheap.c: In function =E2=80=98fibheap_repl=
ace_key_data=E2=80=99:
> >>> ../../binutils/libiberty/fibheap.c:38:24: error: =E2=80=98LONG_MIN=E2=
=80=99 undeclared
> >>> (first use in this function)
> >>>      38 | #define FIBHEAPKEY_MIN LONG_MIN
> >>>         |                        ^~~~~~~~
> >>> [snip]
> >> What SHA1 of https://github.com/kalray/build-scripts are you using?
> > I have executed the "source last.refs"
>
> I was referring to the SHA1 of the repo itself (build-scripts).
>
> `last.refs` is a symbolic link which can point to several releases,
> depending on "when" you did the clone.
>
> I am asking this because we recently published new toolchains.
>
> I want to make sure which one you are trying to build.

Unfortunately I deleted this repo a few minutes before you asked me ;-(
But I remember that I cloned this repo two days ago.
it should be:  last.refs -> refs/4.11.0.refs


> >> We are building our toolchain on Ubuntu 18.04 / 20.04 and 22.04 withou=
t
> >> issues, I don't understand why it does not work for you, although inde=
ed
> >> the error log you are having pops out on my search engine and seems to
> >> be some well known issue.
> > Yes, there are many answers on the web, but none of them solve this pro=
blem.
> >
> >> If the build-script does not work for you, you can still use the
> >> pre-built toolchains generated by the GitHub automated actions:
> >> https://github.com/kalray/build-scripts/releases/tag/v4.11.1 ("latest"
> >> means 22.04)
> > Thanks, this is the final solution ;-)
> Good to see it helped :)
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
