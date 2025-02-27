Return-Path: <linux-arch+bounces-10422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA4A47CFA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 13:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A7A3B1F5C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187C722F151;
	Thu, 27 Feb 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BMe+FVpY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3022E3F0;
	Thu, 27 Feb 2025 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658087; cv=none; b=lSuHMcKubXcdhajbNoOBuUuBmkTd8GDw8C3UuNDi4fgvXL1SsITRtc5aIozNhGH4tnaKrFJfVoU2mveJwNwOfzBgt5rXG6QRYGumfWM9R9S00i0RLAH3T93HJKDA6YIRGxn89QCoYPxMwisxvYrHp6UWpBU5EFB7p8kFs2EVVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658087; c=relaxed/simple;
	bh=T0a5obLc4j2fbIOEajzfIFERecp2iIvOq4FtVxjBxXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMnNr9qLX8MXl5Y5fGXNOv55tsXlwAhZQ6Yg3Iz39sl6IPKGRFnNBSheAf6OhkR8cDSSoXM7686EFSS0Mgz+dElGkXirYVHNI5Rkv6J0+IrE+gg8aqn2+gE/qWX/jefJqUlmkYAiHGnss7U+wV1capU11mET9MCV0xYE43IFMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BMe+FVpY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1CEF740E0202;
	Thu, 27 Feb 2025 12:08:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iN0oCAlGWdj8; Thu, 27 Feb 2025 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740658078; bh=klXDwLNu+GdgxiSQ4cKCu+o7Hgj9jWo4+xGGDdoiKyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMe+FVpYcnybJXXM2DdS37JwfSoPjAjvLDkEei7ZnqXysLs4iK+doGH7m/kT0gYh7
	 ++DAAp3QJBrwYKZDWMkcrgrTUol6djyrM3PAJLTG5gwHcjuWEVB8zNoukan/C/PQ11
	 VBeOyvhKkj6uHDj32a7Vl0dKvIogDTdExZn6ec3gXiNFsTi+RwX2Vi4pQDzZVNTgHZ
	 ZxQKdTlmVprEPa0V7BJX6GypLd04/lkwSOyDPqwnLOi4ISZjn0WbRawbQ+HbKLji+v
	 2nr/ZmneryOruZtGuC9hKOSlT8Qmj0ks+9xX+oUwgVHadfc6UNYe9EDSWRKyFsmqcQ
	 fH5+662Bb9j7+crgFmGFms2EFfEwKBW416LJ3uC/q8CeBjMKIWr+A4nt6CzMP9lOXn
	 Z02/yORitAPE040Sg3gv+PjB2rD2WmrOLlcsTWfgfRltYkWm3z7o52Hn5LPPVQ4JVo
	 in/A7jJlP3/Z1XOb8F5WC/dnYg1y0mm5oNrg7k3EtHqcOn4Yfs2XAscnEr0T+ky2O1
	 Nap2xfrlYXyJvYDw5LNMmUSVqYjSMSWbxCSUtNERR+0ekVMQKOKCsJ6Q+8F8HrrIqr
	 7ubOOnDQNwweaU76vvfKs8TK4hKox8lItZKO9Nh3aofHkBlHoJzNjbCoK3ke/kT4xj
	 A0pA8X13r5RWpUZJZYjU738s=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CE2240E01AE;
	Thu, 27 Feb 2025 12:06:13 +0000 (UTC)
Date: Thu, 27 Feb 2025 13:06:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mike Rapoport <rppt@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org,
	linux-efi@vger.kernel.org, Ofir Weisse <oweisse@google.com>,
	Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH RFC v2 03/29] mm: asi: Introduce ASI core API
Message-ID: <20250227120607.GPZ8BVL2762we1j3uE@fat_crate.local>
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-3-8419288bc805@google.com>
 <20250219105503.GKZ7W4h6QW1CNj48U9@fat_crate.local>
 <CA+i-1C2xK8hzMQ8Y-=-7iYy+27nnouQZu1NdWG0qa35t+OQLqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C2xK8hzMQ8Y-=-7iYy+27nnouQZu1NdWG0qa35t+OQLqw@mail.gmail.com>

On Wed, Feb 19, 2025 at 02:53:03PM +0100, Brendan Jackman wrote:
> Argh, sorry, GMail switched back to HTML mode somehow. Maybe I have to
> get a proper mail client after all.

Yap, wouldn't be such a bad idea. And yes, it ain't easy - we have a whole doc
about it:

Documentation/process/email-clients.rst

> OK, sounds like I need to rewrite this explanation! It's only been
> read before by people who already knew how this thing worked so this
> might take a few attempts to make it clear.
> 
> Maybe the best way to make it clear is to explain this with reference
> to KVM. At a super high level, That looks like:
> 
> ioctl(KVM_RUN) {
>     enter_from_user_mode()
>     while !need_userspace_handling() {
>         asi_enter();  // part 1
>         vmenter();  // part 2
>         asi_relax(); // part 3
>     }
>     asi _exit(); // part 4b
>     exit_to_user_mode()
> }
> 
> So part 4a is just referring to continuation of the loop.
> 
> This explanation was written when that was the only user of this API
> so it was probably clearer, now we have userspace it seems a bit odd.
> 
> With my pseudocode above, does it make more sense? If so I'll try to
> think of a better way to explain it.

Well, it is still confusing. I would expect to see:

ioctl(KVM_RUN) {
    enter_from_user_mode()
    while !need_userspace_handling() {
        asi_enter();  // part 1
        vmenter();  // part 2
        asi_exit(); // part 3
    }
    asi_switch(); // part 4b
    exit_to_user_mode()
}

Because then it is ballanced: you enter the restricted address space, do stuff
and then you exit it without switching address space. But then you need to
switch address space so you have to do asi_exit or asi_switch or wnatnot. And
that's still unbalanced.

So from *only* looking at the usage, it'd be a lot more balanced if all calls
were paired:

ioctl(KVM_RUN) {
    enter_from_user_mode()
    asi_switch_to();			<-------+
    while !need_userspace_handling() {		|
        asi_enter();  // part 1		<---+	|
        vmenter();  // part 2		    |	|
        asi_exit(); // part 3		<---+	|
    }						|
    asi_switch_back(); // part 4b	<-------+
    exit_to_user_mode()
}

(look at me doing ascii paintint :-P)

Naming is awful but it should illustrate what I mean:

	asi_switch_to
	  asi_enter
	  asi_exit
	asi_switch_back

Does that make more sense?

> asi_enter() is actually balanced with asi_relax(). The comment says
> "if we are in it" because technically if you call this asi_relax()
> outside of the critical section, it's a nop. But, there's no reason to
> do that, so we could definitely change the comment and WARN if that
> happens.

See above.

> 
> >
> > > +#define ASI_TAINT_OTHER_MM_CONTROL   ((asi_taints_t)BIT(6))
> > > +#define ASI_NUM_TAINTS                       6
> > > +static_assert(BITS_PER_BYTE * sizeof(asi_taints_t) >= ASI_NUM_TAINTS);
> >
> > Why is this a typedef at all to make the code more unreadable than it needs to
> > be? Why not a simple unsigned int or char or whatever you need?
> 
> 
> My thinking was just that it's nicer to see asi_taints_t and know that
> it means "it holds taint flags and it's big enough" instead of having
> to remember the space needed for these flags. But yeah I'm fine with
> making it a raw integer type.

You're thinking of some of those rules here perhaps?

https://kernel.org/doc/html/latest/process/coding-style.html#typedefs

Probably but then you're using casts (asi_taints_t) to put in integers in it.
Does it matter then?

Might as well use a plain int and avoid the casts, no? Unless there's a real
good reason to have a special type and it is really really good this way...?

> Well it needs to be disambiguated from the field below (currently
> protect_data) but it could be control_to_flush (and data_to_flush).
> 
> The downside of that is that having one say "prevent" and one say
> "protect" is quite meaningful. prevent_control is describing things we
> need to do to protect the system from this domain, protect_data is
> about protecting the domain from the system. However, while that
> difference is meaningful it might not actually be helpful for the
> reader of the code so I'm not wed to it.
> 
> Also worth noting that we could just combine these fields. At present
> they should have disjoint bits set. But, they're used in separate
> contexts and have separate (although conceptually very similar)
> meanings, so I think that would reduce clarity.

Ok, I guess it'll tell us what is better once we stare at that code more. :)

> Ack, I've set up a local thingy to spellcheck all my commits so
> hopefully you should encounter less of that noise in future.

Yeah, I use the default vim spellchecker and it simply works.
 
> For the pronouns stuff I will do my best but you might still spot
> violations in older text, sorry about that.

No worries.

> What this field is describing is: when we run the untrusted code, what
> happens? I don't mean "what does the kernel do" but what physically
> happens on the CPU from an exploit point of view.
> 
> For example setting ASI_TAINT_USER_DATA in this field means "when we
> run the untrusted code (i.e. userspace), userspace data gets left
> behind in sidechannels".
> 
> "Should be set" in the comment means "this field should be set to
> record that a thing has happened" not "this field being set is a
> requirement for some API" or something. So I don't think "required" is
> right but this is hard to name.
> 
> That commentary should also be expanded I think, since "should be set"
> is pretty ambiguous. And maybe if we called it "to_set" it would be
> more obvious that "set" is a verb? I'm very open to suggestions.

I think the explanations you give here should be condensed into comments over
those things. They're really helpful.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

