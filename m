Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43945199DA
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiEDIhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbiEDIhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 04:37:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5769245BD;
        Wed,  4 May 2022 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651653221; x=1683189221;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HLCH8nB4SW/lMh2Z2lGHu7Z1XbytxGyCLhDOE+GPI7E=;
  b=emsEx7nXjWgI+sa0P1QVs7Cjx3dnfgYT5Isrm0a2W6KrTuT/91ueQOiv
   4uB3VpFCEkBruYonIOytLWgmlwgIavX+NFyscTALPRYLWzGvlacqlDY0/
   MkiSorlZGLZx1wzIuKKFlaQhddz992UR04eqztnCmhYjmWrX+NDtLuBkN
   tKijcSL5hWgoacMt7LtWQSSNhBFAscYB0BzxPW5ZhA3vWCj+nGk6b1xPe
   g3nbnAT/lTG+jNAjUqiTCeJS3nNctUWx85/igYcfl+kSckzgpONk/jaxX
   +F0p7OkkZA0YCYQOvShAXwLjMDz786P2qtu2D7kGcMDu8GJ1PRPcST5of
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267580558"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="267580558"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:33:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="562617081"
Received: from unknown (HELO ijarvine-MOBL2) ([10.251.218.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 01:33:34 -0700
Date:   Wed, 4 May 2022 11:33:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] termbits: Convert octal defines to hex
In-Reply-To: <CAK8P3a0hy8Ras7pwF9rJADtCAfeV49K7GWkftJnzqeGiQ6j-zA@mail.gmail.com>
Message-ID: <ca39c741-8d15-33c0-7bd6-635778cc436@linux.intel.com>
References: <2c8c96f-a12f-aadc-18ac-34c1d371929c@linux.intel.com> <CAK8P3a0hy8Ras7pwF9rJADtCAfeV49K7GWkftJnzqeGiQ6j-zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-777826785-1651653220=:1623"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-777826785-1651653220=:1623
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 4 May 2022, Arnd Bergmann wrote:

> On Wed, May 4, 2022 at 9:20 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > Many archs have termbits.h as octal numbers. It makes hard for humans
> > to parse the magnitude of large numbers correctly and to compare with
> > hex ones of the same define.
> >
> > Convert octal values to hex.
> >
> > First step is an automated conversion with:
> >
> > for i in $(git ls-files | grep 'termbits\.h'); do
> >         awk --non-decimal-data '/^#define\s+[A-Z][A-Z0-9]*\s+0[0-9]/ {
> >                 l=int(((length($3) - 1) * 3 + 3) / 4);
> >                 repl = sprintf("0x%0" l "x", $3);
> >                 print gensub(/[^[:blank:]]+/, repl, 3);
> >                 next} {print}' $i > $i~;
> >         mv $i~ $i;
> > done
> >
> > On top of that, some manual processing on alignment and number of zeros.
> > In addition, small tweaks to formatting of a few comments on the same
> > lines.
> >
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Good idea!
> 
> I assume you already checked if additional file contents can be shared across
> architectures? I think I've tried in the past but didn't really get
> anywhere with
> that.
> 
> After applying the patch locally, I still see a bunch of whitespace
> differences in the
> changed lines if I run
> 
> vimdiff arch/*/include/uapi/asm/termbits.h include/uapi/asm-generic/termbits.h
> 
> I think this mostly because you left the sparc version alone (it already
> uses hex constants), but it may be nice to edit this a little more to
> make the actual differences stick out more.

I took a look on further harmonizing, however, it turned out to be not 
that simple. This is basically the pipeline I use to further cleanup the 
differences and remove comments if you want to play yourself, just remove 
stages from the tail to get the intermediate datas (gawk is required for 
--non-decimal-data):

$ git ls-files | grep 'termbits\.h' | xargs grep -h -e '#define' | awk --non-decimal-data '{if (NF < 3) {next}; printf("#define %s\t0x%08x\n", $2, $3)}' | sort | uniq -c | sort | awk '{print $1}' | uniq -c
     82 1
     74 2
     14 3
     58 4
     11 5
     54 6

So only 54 are the same for all archs (non-numeric defines such as EXT[AB] 
will appear as 0x0 but at least those two seem the same across archs 
anyway):
      6 #define B0      0x00000000
      6 #define B110    0x00000003
      6 #define B1200   0x00000009
      6 #define B134    0x00000004
      6 #define B150    0x00000005
      6 #define B1800   0x0000000a
      6 #define B19200  0x0000000e
      6 #define B200    0x00000006
      6 #define B2400   0x0000000b
      6 #define B300    0x00000007
      6 #define B38400  0x0000000f
      6 #define B4800   0x0000000c
      6 #define B50     0x00000001
      6 #define B600    0x00000008
      6 #define B75     0x00000002
      6 #define B9600   0x0000000d
      6 #define BRKINT  0x00000002
      6 #define BS0     0x00000000
      6 #define CMSPAR  0x40000000
      6 #define CR0     0x00000000
      6 #define CRTSCTS 0x80000000
      6 #define CS5     0x00000000
      6 #define ECHO    0x00000008
      6 #define EXTA    0x00000000
      6 #define EXTB    0x00000000
      6 #define FF0     0x00000000
      6 #define IBSHIFT 0x00000010
      6 #define ICRNL   0x00000100
      6 #define IGNBRK  0x00000001
      6 #define IGNCR   0x00000080
      6 #define IGNPAR  0x00000004
      6 #define INLCR   0x00000040
      6 #define INPCK   0x00000010
      6 #define ISTRIP  0x00000020
      6 #define IXANY   0x00000800
      6 #define NL0     0x00000000
      6 #define NL1     0x00000100
      6 #define OCRNL   0x00000008
      6 #define OFDEL   0x00000080
      6 #define OFILL   0x00000040
      6 #define ONLRET  0x00000020
      6 #define ONOCR   0x00000010
      6 #define OPOST   0x00000001
      6 #define PARMRK  0x00000008
      6 #define TAB0    0x00000000
      6 #define TCIFLUSH        0x00000000
      6 #define TCIOFF  0x00000002
      6 #define TCIOFLUSH       0x00000002
      6 #define TCION   0x00000003
      6 #define TCOFLUSH        0x00000001
      6 #define TCOOFF  0x00000000
      6 #define TCOON   0x00000001
      6 #define TCSANOW 0x00000000
      6 #define VT0     0x00000000

Sadly for the others, it just tends to be that one or two are different 
from the rest.



-- 
 i.

--8323329-777826785-1651653220=:1623--
