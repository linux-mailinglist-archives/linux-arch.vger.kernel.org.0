Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588DA4B924D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiBPUdW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 15:33:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiBPUdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 15:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68B918D02D
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 12:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645043588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=esrjKhqDjQRh/iEBpaxk9ksIYgz7Irgaj2mX7UxyKYA=;
        b=bLm8K/yjTIqADGJ5G1bbktfdKEOqBkl+Qd1Ez5Ot2YOeaXjjTeDNxZy/IR7YNZHlK8OIni
        8eWQ5uIv6OCda3l+Qtqc3VGuEYADxHO+ghcLiZLWB6N7cJuSy7xTJXPgQ+TKEgtE61e/Iu
        4Baljqt/ViFXDb+4P7V6UoYc/BCfdGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-Vy3cQXvAM8KFOvE-Jg-Pqw-1; Wed, 16 Feb 2022 15:33:06 -0500
X-MC-Unique: Vy3cQXvAM8KFOvE-Jg-Pqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 423DB1091DA0;
        Wed, 16 Feb 2022 20:33:01 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C152C12E39;
        Wed, 16 Feb 2022 20:32:43 +0000 (UTC)
Date:   Wed, 16 Feb 2022 15:32:41 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v10 02/15] livepatch: avoid position-based search if `-z
 unique-symbol` is available
Message-ID: <Yg1fab6h1rTjVbYO@redhat.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
 <20220209185752.1226407-3-alexandr.lobakin@intel.com>
 <20220211174130.xxgjoqr2vidotvyw@treble>
 <CAFP8O3KvZOZJqOR8HYp9xZGgnYf3D8q5kNijZKORs06L-Vit1g@mail.gmail.com>
 <20220211183529.q7qi2qmlyuscxyto@treble>
 <20220214122433.288910-1-alexandr.lobakin@intel.com>
 <20220214181000.xln2qgyzgswjxwcz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214181000.xln2qgyzgswjxwcz@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 10:10:00AM -0800, Josh Poimboeuf wrote:
> On Mon, Feb 14, 2022 at 01:24:33PM +0100, Alexander Lobakin wrote:
> > > One idea I mentioned before, it may be worth exploring changing the "F"
> > > in FGKASLR to "File" instead of "Function".  In other words, only
> > > shuffle at an object-file granularity.  Then, even with duplicates, the
> > > <file+function> symbol pair doesn't change in the symbol table.  And as
> > > a bonus, it should help FGKASLR i-cache performance, significantly.
> > 
> > Yeah, I keep that in mind. However, this wouldn't solve the
> > duplicate static function names problem, right?
> > Let's say you have a static function f() in file1 and f() in file2,
> > then the layout each boot can be
> > 
> > .text.file1  or  .text.file2
> > f()              f()
> > .text.file2      .text.file1
> > f()              f()
> > 
> > and position-based search won't work anyway, right?
> 
> Right, so we'd have to abandon position-based search in favor of
> file+func based search.
> 
> It's not perfect because there are still a few file+func duplicates.
> But it might be good enough.  We would presumably just refuse to patch a
> duplicate.  Or we could remove them (and enforce their continued removal
> with tooling-based warnings).
> 

You're talking about duplicate file+func combinations as stored in the
symbol table?

From a recent rhel-9 development kernel:

$ readelf --wide --symbols vmlinux | \
  awk '$4=="FILE" { f=$NF } $4=="OBJECT" || $4=="FUNC" { print $4 " " f "::" $NF }' | \
  sort | uniq -c | sort -n | awk '$1 != 1'

      2 FUNC bus.c::new_id_store
      2 FUNC core.c::native_read_msr
      2 FUNC core.c::type_show
      2 FUNC diag.c::sk_diag_fill.constprop.0
      2 FUNC hid-core.c::hid_exit
      2 FUNC hid-core.c::hid_init
      2 FUNC inode.c::remove_one
      2 FUNC iommu.c::__list_del_entry
      2 FUNC msr.c::msr_init
      2 FUNC msr.c::msr_read
      2 FUNC proc.c::c_next
      2 FUNC proc.c::c_start
      2 FUNC proc.c::c_stop
      2 FUNC raw.c::copy_overflow
      2 FUNC raw.c::dst_output
      2 FUNC route.c::dst_discard
      2 FUNC sysfs.c::name_show
      2 FUNC udp.c::copy_overflow
      2 FUNC udp.c::udp_lib_close
      2 FUNC udp.c::udp_lib_hash
      2 FUNC udp.c::udplite_getfrag
      2 FUNC udplite.c::udp_lib_close
      2 FUNC udplite.c::udp_lib_hash
      2 FUNC udplite.c::udplite_sk_init
      2 OBJECT acpi.c::__func__.0
      2 OBJECT amd.c::__already_done.10
      2 OBJECT amd.c::__func__.4
      2 OBJECT amd.c::__func__.5
      2 OBJECT bus.c::driver_attr_new_id
      2 OBJECT bus.c::__func__.1
      2 OBJECT bus.c::__func__.2
      2 OBJECT bus.c::__func__.3
      2 OBJECT bus.c::__func__.4
      2 OBJECT bus.c::__func__.5
      2 OBJECT bus.c::__func__.6
      2 OBJECT bus.c::__func__.7
      2 OBJECT bus.c::__func__.8
      2 OBJECT bus.c::__func__.9
      2 OBJECT cgroup.c::__func__.0
      2 OBJECT class.c::__func__.0
      2 OBJECT class.c::__func__.1
      2 OBJECT class.c::__func__.3
      2 OBJECT class.c::__func__.5
      2 OBJECT class.c::__key.0
      2 OBJECT class.c::__key.1
      2 OBJECT class.c::__key.4
      2 OBJECT core.c::__already_done.18
      2 OBJECT core.c::__already_done.19
      2 OBJECT core.c::__already_done.3
      2 OBJECT core.c::dev_attr_size
      2 OBJECT core.c::dev_attr_start
      2 OBJECT core.c::dev_attr_type
      2 OBJECT core.c::empty_attrs
      2 OBJECT core.c::__func__.10
      2 OBJECT core.c::__func__.14
      2 OBJECT core.c::__func__.7
      2 OBJECT core.c::__func__.9
      2 OBJECT core.c::__key.0
      2 OBJECT core.c::__key.2
      2 OBJECT core.c::__key.3
      2 OBJECT dev.c::__func__.0
      2 OBJECT dir.c::__func__.3
      2 OBJECT driver.c::__func__.0
      2 OBJECT fib_rules.c::__msg.0
      2 OBJECT file.c::__func__.2
      2 OBJECT file.c::__key.1
      2 OBJECT file.c::__key.2
      2 OBJECT hpet.c::__func__.4
      2 OBJECT icmp.c::__func__.1
      2 OBJECT inode.c::__func__.1
      2 OBJECT inode.c::__func__.3
      2 OBJECT intel.c::__already_done.10
      2 OBJECT intel.c::__already_done.11
      2 OBJECT intel.c::__already_done.13
      2 OBJECT ioctl.c::__func__.0
      2 OBJECT iommu.c::__already_done.15
      2 OBJECT iommu.c::__func__.10
      2 OBJECT iommu.c::__func__.2
      2 OBJECT iommu.c::_rs.13
      2 OBJECT iommu.c::_rs.5
      2 OBJECT iommu.c::_rs.9
      2 OBJECT irq.c::__func__.0
      2 OBJECT irq.c::__func__.2
      2 OBJECT irqdomain.c::__func__.0
      2 OBJECT irqdomain.c::__func__.1
      2 OBJECT irqdomain.c::__func__.3
      2 OBJECT main.c::__func__.10
      2 OBJECT main.c::__func__.11
      2 OBJECT main.c::__func__.3
      2 OBJECT main.c::__func__.4
      2 OBJECT main.c::__func__.5
      2 OBJECT manage.c::__func__.1
      2 OBJECT mount.c::__func__.0
      2 OBJECT msr.c::__func__.0
      2 OBJECT ping.c::__func__.1
      2 OBJECT property.c::__func__.3
      2 OBJECT qos.c::__func__.0
      2 OBJECT qos.c::__func__.2
      2 OBJECT resource.c::__func__.1
      2 OBJECT route.c::__key.0
      2 OBJECT route.c::__msg.1
      2 OBJECT route.c::__msg.2
      2 OBJECT route.c::__msg.3
      2 OBJECT route.c::__msg.4
      2 OBJECT route.c::__msg.5
      2 OBJECT route.c::__msg.6
      2 OBJECT swap.c::__func__.0
      2 OBJECT syncookies.c::___done.1
      2 OBJECT syncookies.c::msstab
      2 OBJECT syncookies.c::___once_key.2
      2 OBJECT sysfs.c::dev_attr_name
      2 OBJECT sysfs.c::__key.1
      2 OBJECT sysfs.c::power_attrs
      2 OBJECT udp.c::descriptor.12
      2 OBJECT udp.c::descriptor.13
      2 OBJECT udp.c::__func__.2
      2 OBJECT udp.c::__func__.3
      2 OBJECT udp.c::__func__.4
      2 OBJECT utils.c::__func__.5
      3 FUNC core.c::cmask_show
      3 FUNC core.c::edge_show
      3 FUNC core.c::event_show
      3 FUNC core.c::inv_show
      3 FUNC core.c::umask_show
      3 FUNC inode.c::init_once
      3 OBJECT acpi.c::__func__.1
      3 OBJECT core.c::format_attr_cmask
      3 OBJECT core.c::format_attr_edge
      3 OBJECT core.c::format_attr_event
      3 OBJECT core.c::format_attr_inv
      3 OBJECT core.c::format_attr_umask
      3 OBJECT core.c::__func__.6
      3 OBJECT core.c::__func__.8
      3 OBJECT file.c::__key.3
      3 OBJECT generic.c::__func__.0
      3 OBJECT iommu.c::__func__.0
      3 OBJECT iommu.c::__func__.1
      3 OBJECT iommu.c::__func__.8
      3 OBJECT main.c::__func__.0
      3 OBJECT main.c::__func__.1
      3 OBJECT main.c::__func__.6
      3 OBJECT quirks.c::__func__.0
      3 OBJECT sysfs.c::__func__.0
      4 OBJECT core.c::__func__.4
      5 OBJECT inode.c::tokens
      6 OBJECT core.c::__func__.3
      6 OBJECT core.c::__func__.5
      7 OBJECT core.c::__func__.1
      8 OBJECT core.c::__func__.0
      8 OBJECT core.c::__func__.2

We could probably minimize the FUNC duplicates with unique names, but
I'm not as optimistic about the OBJECTs as most are created via macros
like __already_done.X.  Unless clever macro magic?

Next question: what are the odds that these entries, at least the ones
we can't easily rename, need disambiguity for livepatching?  or
kpatch-build for related purposes?

-- Joe

