Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA093467527
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 11:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhLCKh4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 05:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhLCKh4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 05:37:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCE3C06173E;
        Fri,  3 Dec 2021 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iQOZYPV15R8sQtGsNxxSZM8cpuOcklhqnmhhGetQ6C4=; b=nvYPaHgT4ifzzo6ZzAtpNMUdeU
        FrDvs/TU4zODC/ZwQ/nYZSp/FUL2RMd27qrocg1Havnw6GaM6UHMezi9J4V6V/ewBRyNmTv2Rpd7u
        5GGWCx99PPw6hl4RLTYLEUGeTr74CKTPDn8OABWL3+f5UuRN97l3b5xdK6qbq6vfu/UHlBSn6IqGH
        S1/cTHIi2rfcfV9dwoXjgZiYdtgGfAHJ4BTjTgzRgC5n3tyPYkBW8CCRnOQeHULFSRIagVL87FQ1C
        2ifd5aBe55MvgEEwyZAKi3sXw8bs07TbcwYfreO8WmvK9kcKPd25hs+tSAdlqZa4V+hyZu7kUL6Wx
        2lomda0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt5tH-001ynl-3b; Fri, 03 Dec 2021 10:34:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEC8C300243;
        Fri,  3 Dec 2021 11:34:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 960992B36B3BA; Fri,  3 Dec 2021 11:34:05 +0100 (CET)
Date:   Fri, 3 Dec 2021 11:34:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 03/14] x86: Add support for function granular KASLR
Message-ID: <YanynaifaUNMqQ7p@hirez.programming.kicks-ass.net>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-4-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202223214.72888-4-alexandr.lobakin@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:03PM +0100, Alexander Lobakin wrote:
> +static struct orc_entry *cur_orc_table;
> +static int *cur_orc_ip_table;

> +static int cmp_section_addr_orc(const void *a, const void *b)
> +{
> +	unsigned long ptr = (unsigned long)a;
> +	Elf_Shdr *s = *(Elf_Shdr **)b;
> +	unsigned long end = s->sh_addr + s->sh_size;
> +
> +	/* orc relocations can be one past the end of the section */
> +	if (ptr >= s->sh_addr && ptr <= end)
> +		return 0;
> +
> +	if (ptr < s->sh_addr)
> +		return -1;
> +
> +	return 1;
> +}
> +
> +/*
> + * Discover if the orc_unwind address is in a randomized section and if so,
> + * adjust by the saved offset.
> + */
> +Elf_Shdr *adjust_address_orc(long *address)
> +{
> +	Elf_Shdr **s;
> +	Elf_Shdr *shdr;
> +
> +	if (nofgkaslr)
> +		return NULL;
> +
> +	s = bsearch((const void *)*address, sections, sections_size, sizeof(*s),
> +		    cmp_section_addr_orc);
> +	if (s) {
> +		shdr = *s;
> +		*address += shdr->sh_offset;
> +		return shdr;
> +	}
> +
> +	return NULL;
> +}

> +static inline unsigned long orc_ip(const int *ip)
> +{
> +	return (unsigned long)ip + *ip;
> +}
> +
> +static void orc_sort_swap(void *_a, void *_b, int size)
> +{
> +	struct orc_entry *orc_a, *orc_b;
> +	struct orc_entry orc_tmp;
> +	int *a = _a, *b = _b, tmp;
> +	int delta = _b - _a;
> +
> +	/* Swap the .orc_unwind_ip entries: */
> +	tmp = *a;
> +	*a = *b + delta;
> +	*b = tmp - delta;
> +
> +	/* Swap the corresponding .orc_unwind entries: */
> +	orc_a = cur_orc_table + (a - cur_orc_ip_table);
> +	orc_b = cur_orc_table + (b - cur_orc_ip_table);
> +	orc_tmp = *orc_a;
> +	*orc_a = *orc_b;
> +	*orc_b = orc_tmp;
> +}
> +
> +static int orc_sort_cmp(const void *_a, const void *_b)
> +{
> +	struct orc_entry *orc_a;
> +	const int *a = _a, *b = _b;
> +	unsigned long a_val = orc_ip(a);
> +	unsigned long b_val = orc_ip(b);
> +
> +	if (a_val > b_val)
> +		return 1;
> +	if (a_val < b_val)
> +		return -1;
> +
> +	/*
> +	 * The "weak" section terminator entries need to always be on the left
> +	 * to ensure the lookup code skips them in favor of real entries.
> +	 * These terminator entries exist to handle any gaps created by
> +	 * whitelisted .o files which didn't get objtool generation.
> +	 */
> +	orc_a = cur_orc_table + (a - cur_orc_ip_table);
> +	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
> +}
> +
> +static void update_orc_table(unsigned long map)
> +{
> +	int i;
> +	int num_entries =
> +		(addr___stop_orc_unwind_ip - addr___start_orc_unwind_ip) / sizeof(int);
> +
> +	cur_orc_ip_table = (int *)(addr___start_orc_unwind_ip + map);
> +	cur_orc_table = (struct orc_entry *)(addr___start_orc_unwind + map);
> +
> +	debug_putstr("\nUpdating orc tables...\n");
> +	for (i = 0; i < num_entries; i++) {
> +		unsigned long ip = orc_ip(&cur_orc_ip_table[i]);
> +		Elf_Shdr *s;
> +
> +		/* check each address to see if it needs adjusting */
> +		ip = ip - map;
> +
> +		/*
> +		 * objtool places terminator entries just outside the end of
> +		 * the section. To identify an orc_unwind_ip address that might
> +		 * need adjusting, the address should be compared differently
> +		 * than a normal address.
> +		 */
> +		s = adjust_address_orc(&ip);
> +		if (s)
> +			cur_orc_ip_table[i] += s->sh_offset;
> +	}
> +}
> +
> +static void sort_orc_table(unsigned long map)
> +{
> +	int num_entries =
> +		(addr___stop_orc_unwind_ip - addr___start_orc_unwind_ip) / sizeof(int);
> +
> +	cur_orc_ip_table = (int *)(addr___start_orc_unwind_ip + map);
> +	cur_orc_table = (struct orc_entry *)(addr___start_orc_unwind + map);
> +
> +	debug_putstr("\nRe-sorting orc tables...\n");
> +	sort(cur_orc_ip_table, num_entries, sizeof(int), orc_sort_cmp,
> +	     orc_sort_swap);
> +}

Is this somehow different from what we already have in
arch/x86/kernel/unwind_orc.c for module support? Do we really need two
copies of all that?
