Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD076D7BE5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 13:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjDELs4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjDELsy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 07:48:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C93C3E;
        Wed,  5 Apr 2023 04:48:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ix20so34174922plb.3;
        Wed, 05 Apr 2023 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680695330;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTsmdblHPYajB+3qczYhTQWyrb6fly5Dk4QPH+tzONA=;
        b=gB7rd4W7Gl5XVMiDYxgFsOVckNNSwU82k/ZjQkQT/QUsholqIcv8o2EFrO2eChuzqJ
         /E1Nom6E9OqVZjG1oCeeXIpyYlMTX83oUbH+vrAMBiljmxwpY1NMErmGtwM/4kR1FfAf
         hbb9rumIaGK3o0a+t85nZ9QLJzQAsq6NOQbKus/TppZZYT7cDoYxhqijELG68+PKgXwa
         AW3rV864e3GUeXTY8t245RZh1MUTn2PaCC0EPwp9Ewm661bd+y79Rq+2tRDeDmVVuB2D
         aodRwaRPoLayJHjaBUnU95IZjyqTIp4kVX3Wtfm5NE0FJUdRCcMjEXw7XvCpkJDPa2te
         dhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680695330;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTsmdblHPYajB+3qczYhTQWyrb6fly5Dk4QPH+tzONA=;
        b=X36ryk20NJO3lwOhPpbCitcIGKzvtrHh19hlMIG2B2zNnKiwWtS/gLI2E7Z1xK14fj
         vXJWIOqjZqgZD3dKAsdSRXOm53CAuNrp7eLBu5LPOtql2XclQkoylkA6AdiMubKVqViN
         k+TdcPVazEobBRFn3UR/k8J0W+/0+VuyJzXoF4GPDLPReXsiyIXt4zDyJZDV/hZ3H7zm
         j8Be7QFCcGWF39ksznwhkGFW9a3wUAsm1k4zukR8zW4bcdcfi0MBjy/Ub0hnc03duUCT
         2jdqwfya9zUi0Rhgpxf0JQ1oq3yHB3BhvxE4raYHym+lmXcAJratac6t3Wq8S7wJC+NM
         eV0w==
X-Gm-Message-State: AAQBX9d1PYC006AsQQTmuZ/1a50m7NxIEqBDCNmDwopRXPOYhr9z8tr1
        5hkn6osg1qD/Wf5qArlS+/k=
X-Google-Smtp-Source: AKy350bcdEP3B4h5AyJ/RqXHOvANV432V+AKzzoYSsJ3l0S4OxqL2NCwOgdI7rMZqe9lklSr4+t97g==
X-Received: by 2002:a17:90b:1e49:b0:23f:ef7:7897 with SMTP id pi9-20020a17090b1e4900b0023f0ef77897mr6177640pjb.49.1680695330032;
        Wed, 05 Apr 2023 04:48:50 -0700 (PDT)
Received: from localhost ([103.152.220.91])
        by smtp.gmail.com with ESMTPSA id ha15-20020a17090af3cf00b00233acae2ce6sm1212364pjb.23.2023.04.05.04.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Apr 2023 04:48:49 -0700 (PDT)
Date:   Wed, 5 Apr 2023 04:48:46 -0700
From:   Dan Li <ashimida.1990@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Brian Gerst <brgerst@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        gcc-patches@gcc.gnu.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yuntao Wang <ytcoode@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
Message-ID: <20230405114846.udm4yf3xc6wdyexz@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com>
 <20230327093016.GB4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327093016.GB4253@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/27, Peter Zijlstra wrote:
> On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:
> 
> > In the compiler part[4], most of the content is the same as Sami's
> > implementation[3], except for some minor differences, mainly including:
> > 
> > 1. The function typeid is calculated differently and it is difficult
> > to be consistent.
> 
> This means there is an effective ABI break between the compilers, which
> is sad :-( Is there really nothing to be done about this?

Hi Peter,

I'm not so sure right now. According to Sami's tip, I need to learn more about
related patches. I'll make it ABI compatible in the next version if possible :)

Thanks,
Dan
