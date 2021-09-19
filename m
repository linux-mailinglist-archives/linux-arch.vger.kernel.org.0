Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F534410C81
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhISRGE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 13:06:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:55439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhISRGC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Sep 2021 13:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632071057;
        bh=2M2BrUrsIyz6mQRKWGcclCDZa3TxyUMmrlwcM/+1n1k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XNsWBJ6GNu0ldcNKOkm+PL1xOLrb4Gca5XW/Q+dGK5+knemB9Qnmm/faTOWR1ayjF
         iXdlxig+MMnSLKBfCCwmkKazQm45/+YecNxn/YELdrITfbT2WukmffJNhNRgQguCHm
         uxCPk272cG+b9HRQpwN6yIEaF4FSDpZBQiWlk4EA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.179.84]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1mvCTP1h9a-015rT4; Sun, 19
 Sep 2021 19:04:17 +0200
Date:   Sun, 19 Sep 2021 19:04:11 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: Odd pci_iounmap() declaration rules..
Message-ID: <YUdti08rLzfDZy8S@ls3530>
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
X-Provags-ID: V03:K1:y9isv02tE6wblta4lIZAms8WblnQapCzquMgM/geXKZHthfHdZH
 sCtUAiNhR9qMVTBdVulAKONH65w4iRe+c0+Byz8t8aW7GNmJGA6WqL8l8oggH/apP989qlk
 Vd3EDog6+tzXRxlpGcPushrqt6h4Hd7Jkwl/PFS1aZQGyxVG8ufw3gDn5kIlXtLNVEtODYm
 YtuaEWm2+ew4RGQZTl1HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jwX7SaxFyVg=:UFOvEth/m9zZ1NcApM3ybx
 tmxszJdZMmOoWbgBEibgnoQ9r+njP7cod/I134SG10ZTY4lnrk2Vd8fNZUXSRf8Lko67E+Lh9
 6RW3zXvqIbMu8GIZLxU+2pe8JFqQD5L18p5S5mPCVGPx9pE4lcmZhoVWrRQj+YvcxYrG0p5fl
 3SV+YGRqYyIDGSWau/revXTx25m+nToaDUN4J1f0YR9bKRwT3xeB2Qamfs/fCpbt+0UL7NWRB
 gRgJW8fIOsov/Gm8GDJO4ehq8Lv7ekPJbdeVkdYzjwkCdsxacYFDlt/3AjB2kqIC8HhOj3x+n
 Jngov8+60KohF5VV5Dxx4rjMOpoiN3ZlTZfO8D3CIjUZJby/IeNa1CpV5W/TqbF2MVYgnw666
 POzNwgczckpvpjze0cN6Y8JXLh7TU1XGw6+IfEVnPVrl3giEi0myZKjGjOgEmcsdy5/x1OMNl
 F+GEEz0gDSeGCfMMHNij9f38+pFqf8p1N+zJE6rPf8w/osoMY0J6U0JxHLd8PwfPB4g4oxX4b
 +Z9uWvc7F22h5rtjJxVi986o5gpxeGng1l8NQXZdKEo0q1f0LUiXO/nSwTGI0jRat7qqZ1T5Q
 c2nleEN52Jj33Y9Jjsy4nsEz/Op7baojYUKqvsfRBJ8jKFNmo50yfQfAc8KByvT/TBTfugUg5
 C++N9oL689eetXkWG4CYwRIfZLqzCoe2MuIAWmd51KocvueIZ2TVEPMYR58K0y6IdK5x7oxAM
 M/RkEergqgeoI+F9pqbBOSPY+f5XxVsvD9aCqS9bbnWNW8D+lepuW1yMswhVvPS8zJjkiT8SN
 gkCRcUwsbSMH/0T17hEyL+MtzEaj6AcW1py/2UEkW9BEdbmCLLt3i/yf790rs8/D/XV18uIJU
 rO1Y259LFhGFCSY7jJMdEjcxJmdsAAV7oSrKkY1SM8D4JPJu9FWnWyLIjU5dyfd8Skh8YE+gG
 SXiM90PdJos+vBo9+V+YwUUAVGJMJ7hUZeZKURsRPWaStIsBI47gWVeMdv8sdcj5SB83fTxnt
 WpV+9F7PkV36HQbD8bfS2FiOTYdpKMSg7383a4gtbM9WFB//wRmfEkdihI2WKGBR0USEUiZSr
 Gga6sLUqsIC1xc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org>:
> So I was looking at a patch by Ulrich that reportedly got the alpha
> 'Jensen' platform compile going again, and while it didn't work for
> me, a slightly modified one did get it mostly working. See commit
> cc9d3aaa5331 ("alpha: make 'Jensen' IO functions build again") for
> entirely irrelevant details.
>
> Anyway, that particular case doesn't really matter, but the Jensen
> configuration is somewhat interesting in that it doesn't have
> CONFIG_PCI (and alpha doesn't do CONFIG_PM), and it turns out that
> breaks some other things.  Some of them are just random driver issues,
> not a big deal.
>
> But one particular case is odd: "pci_iounmap()" behavior is all kinds of=
 crazy.
>
> Now, to put that in perspective, look at pci_iomap(), and it's
> actually fairly normal, and handled in
> include/asm-generic/pci_iomap.h, with a fairly sane
>
>   #ifdef CONFIG_PCI
>   .. real declaration ..
>   #elif defined(CONFIG_GENERIC_PCI_IOMAP)
>   .. empty declaration ..
>   #endif
>
> although you can kind of see some oddity there if you look at the
> declaration of the __pci_ioport_map() thing for the special case of
> port remapping. Whatever. On the whole, you have that "declare for
> PCI, otherwise have empty declarations so that non-PCI systems can
> still build cleanly".
>
> Now, alpha makes the mistake of making that GENERIC_PCI_IOMAP thing
> conditional on having PCI at all:
>
>         select GENERIC_PCI_IOMAP if PCI
>
> which then means that the "non-PCI systems can still build cleanly"
> doesn't actually end up working, but whatever.  It does point out that
> maybe that
>
>   #elif defined(CONFIG_GENERIC_PCI_IOMAP)
>
> should perhaps just be a #else. Because it's kind of silly to only
> have those empty declarations if PCI is _not_ enabled, but
> GENERIC_PCI_IOMAP is enabled. Most architectures seem to just select
> GENERIC_PCI_IOMAP unconditionally, and it also gets selected magically
> for you if you pick GENERIC_IOMAP.
>
> So it's all a bit illogical, and slightyl complicated, but it doesn't
> seem to be a huge deal.
>
> What is *entirely* illogical is the state of "pci_iounmap()", though.
>
> You'd think that it would mirror pci_iomap(), wouldn't you? The two go
> literally hand-in-hand and pair up, after all.
>
> But no. Not at all.
>
> pci_iounmap() is decared not in include/asm-generic/pci_iomap.h
> together with pci_iomap(), but in include/asm-generic/iomap.h.
>
> And it has a different #ifdef too, doing
>
>   #ifdef CONFIG_PCI
>   .. delcaration..
>   #elif defined(CONFIG_GENERIC_IOMAP)
>   .. empty implementation ..
>   #endif
>
> which makes _no_ sense. Except it seems to be paired with this one in
> asm-generic/io.h (!!):
>
>   #ifndef CONFIG_GENERIC_IOMAP
>   .. declaration  for pci_iomap() ..
>
>   #ifndef pci_iounmap
>   #define pci_iounmap pci_iounmap
>   static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
>   {
>         __pci_ioport_unmap(p);
>   }
>   #endif
>   #endif /* CONFIG_GENERIC_IOMAP */
>
> which really makes no sense at all.
>
> So there's GENERIC_IOMAP, and there is GENERIC_PCI_IOMAP, and the
> _former_ modifies the behavior of "pci_iounmap()", but the _latter_
> (more logically) modifies the behavior of "pci_iomap()".
>
> I think this may at least partly just be a mistake. See commit
> 97a29d59fc22 ("[PARISC] fix compile break caused by iomap: make
> IOPORT/PCI mapping functions conditional") which added those two
> different CONFIG_ tests. The different config option kind of makes
> sense in the context of which header file the declaration was in, but
> I think _that_ in turn was just an older confusing mistake.
>
> I'd like to fix some of the alpha issues by just making alpha do
>
>         select GENERIC_PCI_IOMAP
>
> unconditionally, so that if PCI isn't enabled, it gets the default
> empty implementation.
>
> But that doesn't work right now, because of the crazy situation with
> pci_iounmap().
>
> I think the right fix would be to(),
>
>  (a) move pci_iounmap() declaration to
> include/asm-generic/pci_iomap.h, and use the sane GENERIC_PCI_IOMAP
> config option for it (or even better, remove that #elif entirely and
> make it just #else
>
>  (b) if you want to make your own pci_iounmap(), you just implement
> your own one, and don't play games in the header file.
>
> Hmm? Comments? Added random people who have been involved in this
> (commit 97a29d59fc22 is from James, replaced him with Helge instead).

I do agree.

The attached patch implements (a) and (b) and builds and boots cleanly
on my non-PCI machine with CONFIG_PCI=3Dn and GENERIC_PCI_IOMAP=3Dy and I
assume it fixes your alpha build as well.

I assume the problem arised from the fact that pci_iounmap() was defined
on parisc unconditionally even for CONFIG_PCI=3Dn.

Can you test if it fixes your alpha build (with GENERIC_PCI_IOMAP=3Dy) as
well?

Helge
=2D--
=46rom 6f2f2855d05ca056481dbc446802826f70247b4c Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Sun, 19 Sep 2021 18:45:45 +0200
Subject: [PATCH] parisc: Declare pci_iounmap() parisc version only when
 CONFIG_PCI enabled

Linus noticed odd declaration rules for pci_iounmap() in iomap.h and
pci_iomap.h, where it was dependend on either
CONFIG_NO_GENERIC_PCI_IOPORT_MAP or CONFIG_GENERIC_IOMAP when CONFIG_PCI
was disabled.

Testing on parisc seems to indicate that we need pci_iounmap() only when
CONFIG_PCI is enabled, so the declaration of pci_iounmap() can be moved
cleanly into pci_iomap.h in sync with the declarations of pci_iomap().

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 97a29d59fc22 ("[PARISC] fix compile break caused by iomap: make IOP=
ORT/PCI mapping functions conditional")

diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index f03adb1999e7..367f6397bda7 100644
=2D-- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -513,12 +513,15 @@ void ioport_unmap(void __iomem *addr)
 	}
 }

+#ifdef CONFIG_PCI
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
 	if (!INDIRECT_ADDR(addr)) {
 		iounmap(addr);
 	}
 }
+EXPORT_SYMBOL(pci_iounmap);
+#endif

 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
@@ -544,4 +547,3 @@ EXPORT_SYMBOL(iowrite16_rep);
 EXPORT_SYMBOL(iowrite32_rep);
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
-EXPORT_SYMBOL(pci_iounmap);
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 9b3eb6d86200..08237ae8b840 100644
=2D-- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -110,16 +110,6 @@ static inline void __iomem *ioremap_np(phys_addr_t of=
fset, size_t size)
 }
 #endif

-#ifdef CONFIG_PCI
-/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
-struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
-#elif defined(CONFIG_GENERIC_IOMAP)
-struct pci_dev;
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{ }
-#endif
-
 #include <asm-generic/pci_iomap.h>

 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iom=
ap.h
index df636c6d8e6c..5a2f9bf53384 100644
=2D-- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -18,6 +18,7 @@ extern void __iomem *pci_iomap_range(struct pci_dev *dev=
, int bar,
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectur=
es
  * to override */
@@ -50,6 +51,8 @@ static inline void __iomem *pci_iomap_wc_range(struct pc=
i_dev *dev, int bar,
 {
 	return NULL;
 }
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{ }
 #endif

 #endif /* __ASM_GENERIC_PCI_IOMAP_H */

