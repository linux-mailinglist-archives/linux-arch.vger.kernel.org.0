Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E696D7BEE
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 13:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjDELtj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjDELti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 07:49:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997C40DA;
        Wed,  5 Apr 2023 04:49:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kq3so34131824plb.13;
        Wed, 05 Apr 2023 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680695367;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1BOAPHjvwBZc8su+MgbgVVdFrkx9EshhGySuq8Rik0=;
        b=Bt3SQPjIlscA+YIQGeFDeWCjFaY/IR7cWnrRvQAR6vJkLhPdBaa1HtFhU5RDFhLPFS
         FgPhiqGgarOmcstcwvnrj1unU+Oq0zSOgn/hF9ZmgnSuicgEVf7yUrvwF2Nq+uPydIXo
         Z8ar3S5OvmK/sytW1z6tji3TXij9oF89N6PEFZSldNA9UB6Bi35y85z74Ao5P1ZbjIFL
         eQxx4+xBUmbD8ii8AbLRXjF51uAXluK/BR6Ntz8wilstrllzXtlmFTgB9vsFqdg3w6w0
         I5bdIMV+HtJ64KrfmNnKPZfNjlb1mQhWlImR42Pv0HEKYXXOOla/rObROI06I5Abhv+8
         Ii9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680695367;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1BOAPHjvwBZc8su+MgbgVVdFrkx9EshhGySuq8Rik0=;
        b=E4eTsd4+WeA6t3lbd8ndnE8ahemrcirlqookLyJswMdD5r6LSphnLG4gvcav7WIvo8
         /89fHYh3T4ovoKtqM4l+C4sSoWFfjG5cmeLME02S5oDmSOe18vDYORzhNhxxVpklTN7Z
         Lo5CSw4dikmi2yOIjm+QdUH7OgqbhqcIfTmqj4V34BVkKlQdFnfaAgvNlWYgEUEwtjFk
         CZIwpmAiq+dqG7qaSgNEl8R5acBFNI0QpLIt3M/XgyT8rJdDBSbA1tsjdI2Df/k/u+Eq
         vkS/m66kZsP6fZq0Yehv9xTGxnFWgp3B2QnlLPV1p/GAWevZby/K4pNzI7ggKnPp0qng
         xQMA==
X-Gm-Message-State: AAQBX9e3Kea3G06bCyKgbjUzbBCMSS/x1ysa9+Uoio0WcCj4tJC/dZNj
        jI+byGJQROAJblXJ0ARBR3U=
X-Google-Smtp-Source: AKy350bSLOSqLBm8ShGZT00MxdAH6lu+lyUWEYbCEe4/MMf46RL/sqlXgZqYxCwRurEr1EetQSWcYQ==
X-Received: by 2002:a17:902:e494:b0:19c:a866:6a76 with SMTP id i20-20020a170902e49400b0019ca8666a76mr5179345ple.42.1680695367063;
        Wed, 05 Apr 2023 04:49:27 -0700 (PDT)
Received: from localhost ([103.152.220.91])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902868800b0019cbabf127dsm9938617plo.182.2023.04.05.04.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Apr 2023 04:49:26 -0700 (PDT)
Date:   Wed, 5 Apr 2023 04:49:24 -0700
From:   Dan Li <ashimida.1990@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Aaron Tomlin <atomlin@redhat.com>,
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
Message-ID: <20230405114924.v7p76tzwmecquz2q@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com>
 <20230327093016.GB4253@hirez.programming.kicks-ass.net>
 <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
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

On 03/27, Sami Tolvanen wrote:
> On Mon, Mar 27, 2023 at 2:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:
> >
> > > In the compiler part[4], most of the content is the same as Sami's
> > > implementation[3], except for some minor differences, mainly including:
> > >
> > > 1. The function typeid is calculated differently and it is difficult
> > > to be consistent.
> >
> > This means there is an effective ABI break between the compilers, which
> > is sad :-( Is there really nothing to be done about this?
> 
> I agree, this would be unfortunate, and would also be a compatibility
> issue with rustc where there's ongoing work to support
> clang-compatible CFI type hashes:
> 
> https://github.com/rust-lang/rust/pull/105452
> 
> Sami

Hi Sami,

Thanks for the info, I need to learn about it :)
Is there anything else that needs to be improved?

Thanks,
Dan
