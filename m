Return-Path: <linux-arch+bounces-1005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBFB81151F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F781C21119
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB062EAF7;
	Wed, 13 Dec 2023 14:45:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66586110;
	Wed, 13 Dec 2023 06:45:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10C39FEC;
	Wed, 13 Dec 2023 06:46:09 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.42.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3A93F738;
	Wed, 13 Dec 2023 06:45:13 -0800 (PST)
Date: Wed, 13 Dec 2023 14:45:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Wang <wanglikun@lixiang.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Aaron Tomlin <atomlin@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
	Brian Gerst <brgerst@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Changbin Du <changbin.du@intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Frederic Weisbecker <frederic@kernel.org>, gcc-patches@gcc.gnu.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Marco Elver <elver@google.com>, Mark Brown <broonie@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Miguel Ojeda <ojeda@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Song Liu <song@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	Yuntao Wang <ytcoode@gmail.com>, Yu Zhao <yuzhao@google.com>,
	Zhen Lei <thunder.leizhen@huawei.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dan Li <ashimida.1990@gmail.com>
Subject: Re: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
Message-ID: <ZXnDdooZv0of64ZK@FVFF77S0Q05N>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com>
 <20230327093016.GB4253@hirez.programming.kicks-ass.net>
 <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
 <CAE+Z0PFZaa2bwtfY5P7ZDYH4JjMxKpJgqz0m+KJ_ks4dctzAKA@mail.gmail.com>
 <4a84af95-6270-6764-6a40-875ec20fc3e1@lixiang.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a84af95-6270-6764-6a40-875ec20fc3e1@lixiang.com>

On Wed, Dec 13, 2023 at 05:01:07PM +0800, Wang wrote:
> On 2023/12/13 16:48, Dan Li wrote:
> > + Likun
> >
> > On Tue, 28 Mar 2023 at 06:18, Sami Tolvanen wrote:
> >> On Mon, Mar 27, 2023 at 2:30 AM Peter Zijlstra wrote:
> >>> On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:
> >>>
> >>>> In the compiler part[4], most of the content is the same as Sami's
> >>>> implementation[3], except for some minor differences, mainly including:
> >>>>
> >>>> 1. The function typeid is calculated differently and it is difficult
> >>>> to be consistent.
> >>> This means there is an effective ABI break between the compilers, which
> >>> is sad :-( Is there really nothing to be done about this?
> >> I agree, this would be unfortunate, and would also be a compatibility
> >> issue with rustc where there's ongoing work to support
> >> clang-compatible CFI type hashes:
> >>
> >> https://github.com/rust-lang/rust/pull/105452
> >>
> >> Sami
> 
> Hi Peter and Sami
> 
> I am Dan Li's colleague, and I will take over and continue the work of CFI.
> 
> Regarding the issue of gcc cfi type id being compatible with clang, we
> have analyzed and verified:
> 
> 1. clang uses Mangling defined in Itanium C++ ABI to encode the function
> prototype, and uses the encoding result as input to generate cfi type id;
> 2. Currently, gcc only implements mangling for the C++ compiler, and the
> function prototype coding generated by these interfaces is compatible
> with clang, but gcc's c compiler does not support mangling.;
> 
> Adding mangling to gcc's c compiler is a huge and difficult task，because
> we have to refactor the mangling of C++, splitting it into basic
> mangling and language specific mangling, and adding support for the c
> language which requires a deep understanding of the compiler and
> language processing parts.
> 
> And for the kernel cfi, I suggest separating type compatibility from CFI
> basic functions. Type compatibility is independent from CFI basic
> funcitons and should be dealt with under another topic. Should we focus
> on the main issus of cfi, and  let it work first on linux kernel, and
> left the compatible issue to be solved later?

I'm not sure what you're suggesting here exactly, do you mean to add a type ID
scheme that's incompatible with clang, leaving everything else the same? If so,
what sort of scheme are you proposing?

It seems unfortunate to have a different scheme, but IIUC we expect all kernel
objects to be built with the same compiler.

Mark.

