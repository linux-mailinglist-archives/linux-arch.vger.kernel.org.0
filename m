Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAD6626EA
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjAINZG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 08:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjAINZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 08:25:05 -0500
X-Greylist: delayed 223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 05:25:03 PST
Received: from fx405.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE7CCE
        for <linux-arch@vger.kernel.org>; Mon,  9 Jan 2023 05:25:03 -0800 (PST)
Received: from localhost (fx405.security-mail.net [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id E1B31335F3E
        for <linux-arch@vger.kernel.org>; Mon,  9 Jan 2023 14:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1673270478;
        bh=VTyAgBvawac4uHB7eMyMDicCX2xLvVfQ11WRs4OqUgg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YZ+jS6/1Ma7JCmcJ3+OEDQF6/jdcWUhHaMCMCUIMiS/QRA3hvieFeCchl43TWG6g4
         8uzP1OQwFTqJST5NGfflnAynHPXH43mmkQhylk6XZiFnOpe64YOUPMjH/EHaBa+r6X
         XNQwFD9kMcy8gj0OVjfaZ+Y+swU0mq962ckt9ZPA=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 382DC335EA5; Mon,  9 Jan
 2023 14:21:18 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 1E46D335E6D; Mon,  9 Jan
 2023 14:21:17 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D765927E03FF; Mon,  9 Jan 2023
 14:21:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id B3B4327E03FA; Mon,  9 Jan 2023 14:21:16 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 RFDkxXP_U9mz; Mon,  9 Jan 2023 14:21:16 +0100 (CET)
Received: from [192.168.37.161] (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 46FC927E03F5; Mon,  9 Jan 2023
 14:21:16 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <18db.63bc14cd.171d3.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu B3B4327E03FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1673270476;
 bh=pFwL+Y0S0qo0MF7wO/awAfpxvBk+/1wXJh5pVmIIW2g=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=XjT0yLLBY18QxivMgV9uczq9z+HpKf5TnyecD/FGL3y5WOfaxlypJyAxpZ8saNN2c
 xkoB4C8EPYxurJyqIoGRHgJxE+LjZeyAAIvw8YYk1DjcyoP679xtmnwZh9BbBCh3Ku
 YVP4+a/ZNoUFvoUsbRjrSO4n7fz2l6dahOcJsTh0=
Message-ID: <6570d22d-ee19-f8b1-6fb4-bf8865ec4142@kalray.eu>
Date:   Mon, 9 Jan 2023 14:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
Content-Language: en-us
To:     Jeff Xie <xiehuan09@gmail.com>
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
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <CAEr6+ECRh_9App18zmcS6FUR81YYhR=n4kGdeZAtQBsdMB55_A@mail.gmail.com>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <CAEr6+ECRh_9App18zmcS6FUR81YYhR=n4kGdeZAtQBsdMB55_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jeff,

On 1/7/23 07:25, Jeff Xie wrote:
> Hi,
>
> On Wed, Jan 4, 2023 at 1:01 AM Yann Sionneau <ysionneau@kalray.eu> wrote:
>> [snip]
>>
>> A kvx toolchain can be built using:
>> # install dependencies: texinfo bison flex libgmp-dev libmpc-dev libmpfr-dev
>> $ git clone https://github.com/kalray/build-scripts
>> $ cd build-scripts
>> $ source last.refs
>> $ ./build-kvx-xgcc.sh output
> I would like to build the kvx-xgcc to compile and test the linux
> kernel, but it reported a compile error.
> I wonder what version of gcc you are using.
>
> My build environment:
> VERSION="20.04.2 LTS (Focal Fossa)"
> gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)
>
>
> Compile error:
> $ ./build-kvx-xgcc.sh output
>
> ../../binutils/libiberty/fibheap.c: In function ‘fibheap_replace_key_data’:
> ../../binutils/libiberty/fibheap.c:38:24: error: ‘LONG_MIN’ undeclared
> (first use in this function)
>     38 | #define FIBHEAPKEY_MIN LONG_MIN
>        |                        ^~~~~~~~
> [snip]

What SHA1 of https://github.com/kalray/build-scripts are you using?

We are building our toolchain on Ubuntu 18.04 / 20.04 and 22.04 without 
issues, I don't understand why it does not work for you, although indeed 
the error log you are having pops out on my search engine and seems to 
be some well known issue.

If the build-script does not work for you, you can still use the 
pre-built toolchains generated by the GitHub automated actions: 
https://github.com/kalray/build-scripts/releases/tag/v4.11.1 ("latest" 
means 22.04)

I hope it will work for you.

Regards,

-- 

Yann





