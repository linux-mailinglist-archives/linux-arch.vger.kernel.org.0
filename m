Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9265EE80
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 15:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjAEONS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 09:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjAEOMv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 09:12:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736B5791F;
        Thu,  5 Jan 2023 06:12:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C58B81AEB;
        Thu,  5 Jan 2023 14:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A407C433EF;
        Thu,  5 Jan 2023 14:12:40 +0000 (UTC)
Date:   Thu, 5 Jan 2023 09:12:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Jules Maselbas" <jmaselbas@kalray.eu>,
        "Yann Sionneau" <ysionneau@kalray.eu>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Boqun Feng" <boqun.feng@gmail.com>, bpf@vger.kernel.org,
        "Christian Brauner" <brauner@kernel.org>,
        devicetree@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Eric Paris" <eparis@redhat.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Jan Kiszka" <jan.kiszka@siemens.com>,
        "Jason Baron" <jbaron@akamai.com>, "Jiri Olsa" <jolsa@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Kieran Bingham" <kbingham@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-audit@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Waiman Long" <longman@redhat.com>,
        "Will Deacon" <will@kernel.org>, "Alex Michon" <amichon@kalray.eu>,
        "Ashley Lesdalons" <alesdalons@kalray.eu>,
        "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
        "Clement Leger" <clement.leger@bootlin.com>,
        "Guillaume Missonnier" <gmissonnier@kalray.eu>,
        "Guillaume Thouvenin" <gthouvenin@kalray.eu>,
        "Jean-Christophe Pince" <jcpince@gmail.com>,
        "Jonathan Borne" <jborne@kalray.eu>,
        "Julian Vetter" <jvetter@kalray.eu>,
        "Julien Hascoet" <jhascoet@kalray.eu>,
        "Julien Villette" <jvillette@kalray.eu>,
        "Louis Morhet" <lmorhet@kalray.eu>,
        "Luc Michel" <lmichel@kalray.eu>,
        Marc =?UTF-8?B?UG91bGhpw6hz?= <dkm@kataplop.net>,
        "Marius Gligor" <mgligor@kalray.eu>,
        "Samuel Jones" <sjones@kalray.eu>,
        "Thomas Costis" <tcostis@kalray.eu>,
        "Vincent Chardon" <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
Message-ID: <20230105091238.42bd6e6f@gandalf.local.home>
In-Reply-To: <5b69db0b-9eed-42ce-8e93-4b656022433f@app.fastmail.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
        <7c531595-e987-422b-bcf7-48ad0ba49ce6@app.fastmail.com>
        <20230105104019.GA7446@tellis.lin.mbt.kalray.eu>
        <5b69db0b-9eed-42ce-8e93-4b656022433f@app.fastmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 05 Jan 2023 13:05:32 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> >> I did not receive most of the other patches as I'm
> >> not subscribed to all the mainline lists. For future 
> >> submissions, can you add the linux-arch list to Cc for
> >> all patches?  
> >
> > We misused get_maintainers.pl, running it on each patch instead
> > of using it on the whole series. next time every one will be in
> > copy of every patch in the series and including linux-arch.  
> 
> Be careful not to make the list too long though, there is
> usually a limit of 1024 characters for the entire Cc list,
> above this your mails may get dropped by the mailing lists.

It's best to include mailing lists for the entire series, and perhaps
individuals for each patch. As I don't want the entire series just to see
the tracing portion.

-- Steve
