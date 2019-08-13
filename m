Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5498B86F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfHMMUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:20:14 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42555 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfHMMTH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:19:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id e22so34008879qtp.9
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6PgFwT5ybpsMvR73n2NchUIwCDCLdMXSL/zekwZUPV0=;
        b=jD9ZzgIfaS51gL704kQ5B3pyAxRwAkFR5KAAxqD03+kRrbNxZasQJhXNSpL5IUD3WC
         2DcnSWgyDaPoRPIGpldT8mFFTh+D7IvMFxHm7iTt3sA8pZKFy6cUm7d9XJwv/DbGCbp4
         apBL8JeZNEGLLuEGK/kJMrUVLy5ehYl2bswCIbpRo4AUdG9z8T7qN7EYG2g6iDYunndi
         bgvRTsfFKIeh+lV0TGQh07MMCHE7knk8t4nlw97npIIZj92U8RBDn5AI9/CVxQe6kk0P
         ifVqrzVa67t41udCVDvV3Mua+k4Gh9mqtC5Z6kseL7iHwIkqxHgzBvcScP5+7WLk7K57
         pDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6PgFwT5ybpsMvR73n2NchUIwCDCLdMXSL/zekwZUPV0=;
        b=LBMl+1savzB3jItKyxboa7eCkW2yV0plIY3rUODzO1Mhp43rmR0YA1eT/NFtfHcwRN
         Ok6YNFzWQ7a+nRGX7jCXYcs/gRIagh8sQj7JWUzLQNXTnEqqBVFjzeMxF2p+O2TboNkL
         KQMJtvejvQ8ravOClOlhuT7T6RNBF5VAxZFGkOL9MvmdpbtKb2KJcLzzFomsySfYOhh0
         b/jtsD6kR0iVO+DTY93/KcxhkKiqola/Dpcn+fBMQCbxWw3CsAOJnb1w4emukmSPXXzz
         /Nn8zAe9SdBdREDR31tuCsyMR0fwsdclRAumMYPW0ginh8F7cOzpaHnL1f4ULNpjYIXq
         gkEA==
X-Gm-Message-State: APjAAAUM2ljxf38E8Nzbcp4yfyntrnK5QEkCbkN3CrKhiT3uSTNdBbwF
        SN32zLRpsL4q9sr6Y5ql5H5SY5zuUxZbkQ==
X-Google-Smtp-Source: APXvYqwoPPvVp4wXK2/Ekm9uHbCBVrd0HTIovQY6Rl1JP2NcFK3PdJFfhx8kL4FpENxmnwm0ne/g50Y+okhRyQ==
X-Received: by 2002:a0c:e28e:: with SMTP id r14mr11313674qvl.32.1565698744842;
 Tue, 13 Aug 2019 05:19:04 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:16:57 +0100
In-Reply-To: <20180716122125.175792-1-maco@android.com>
Message-Id: <20190813121733.52480-1-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 0/10] Symbol namespaces - RFC
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com, Adrian Reber <adrian@lisas.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        cocci@systeme.lip6.fr, Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As of Linux 5.3-rc4, there are 31203 [1] exported symbols in the kernel.
That is a growth of almost 1000 symbols since 4.17 (30206 [2]).  There
seems to be some consensus amongst kernel devs that the export surface
is too large, and hard to reason about.

Generally, these symbols fall in one of these categories:
1) Symbols actually meant for drivers
2) Symbols that are only exported because functionality is split over
   multiple modules, yet they really shouldn't be used by modules outside
   of their own subsystem
3) Symbols really only meant for in-tree use

When module developers try to upstream their code, it regularly turns
out that they are using exported symbols that they really shouldn't be
using. This problem is even bigger for drivers that are currently
out-of-tree, which may be using many symbols that they shouldn't be
using, and that break when those symbols are removed or modified.

This patch allows subsystem maintainers to partition their exported
symbols into separate namespaces, and module authors to import such
namespaces only when needed.

This allows subsystem maintainers to more easily limit availability of
these namespaced symbols to other parts of the kernel. It can also be
used to partition the set of exported symbols for documentation
purposes; for example, a set of symbols that is really only used for
debugging could be in a "SUBSYSTEM_DEBUG" namespace.

I continued the work mainly done by Martijn Coenen. In this v2 the
following changes have been introduced compared to v1 of this series:

- Rather than adding and evaluating separate sections __knsimport_NS,
  use modinfo tags to declare the namespaces a module introduces.
  Adjust modpost and the module loader accordingly.
- Also add support for reading multiple modinfo values for the same tag
  to allow list-like access to modinfo tags.
- The macros in export.h have been cleaned up to avoid redundancy in the
  macro parameters (ns, nspost, nspost2).
- The introduction of relative references in the ksymtab entries caused
  a rework of the macros to accommodate that configuration as well.
- Alignment of kernel_symbol in the ksymtab needed to be fixed to allow
  growing the kernel_symbol struct.
- Modpost does now also append the namespace suffix to the symbol
  entries in Module.symvers.
- The configuration option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS allows
  relaxing the enforcement of properly declared namespace imports at module
  loading time.
- Symbols can be collectively exported into a namespace by defining
  DEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile.
- The requirement for a very recent coccinelle spatch has been lifted by
  simplifying the script.
- nsdeps does now ensures MODULE_IMPORT_NS statements are sorted when
  patching the module source files.
- Some minor bugs have been addressed in nsdeps to allow it to work with
  modules that have more than one source file.
- The RFC for the usb-storage symbols has been simplified by using
  DEFAULT_SYMBOL_NAMESPACE=USB_STORAGE rather than explicitly exporting each
  and every symbol into that new namespace.

This patch series was developed against v5.3-rc4.

[1] git grep "^EXPORT_SYMBOL\w*(" v5.3-rc4 | wc -l
[2] git grep "^EXPORT_SYMBOL\w*(" v4.17    | wc -l

Matthias Maennich (10):
  module: support reading multiple values per modinfo tag
  export: explicitly align struct kernel_symbol
  module: add support for symbol namespaces.
  modpost: add support for symbol namespaces
  module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
  export: allow definition default namespaces in Makefiles or sources
  modpost: add support for generating namespace dependencies
  scripts: Coccinelle script for namespace dependencies.
  usb-storage: remove single-use define for debugging
  RFC: usb-storage: export symbols in USB_STORAGE namespace

 MAINTAINERS                                 |   5 +
 Makefile                                    |  12 ++
 arch/m68k/include/asm/export.h              |   1 -
 drivers/usb/storage/Makefile                |   2 +
 drivers/usb/storage/alauda.c                |   1 +
 drivers/usb/storage/cypress_atacb.c         |   1 +
 drivers/usb/storage/datafab.c               |   1 +
 drivers/usb/storage/debug.h                 |   2 -
 drivers/usb/storage/ene_ub6250.c            |   1 +
 drivers/usb/storage/freecom.c               |   1 +
 drivers/usb/storage/isd200.c                |   1 +
 drivers/usb/storage/jumpshot.c              |   1 +
 drivers/usb/storage/karma.c                 |   1 +
 drivers/usb/storage/onetouch.c              |   1 +
 drivers/usb/storage/realtek_cr.c            |   1 +
 drivers/usb/storage/scsiglue.c              |   2 +-
 drivers/usb/storage/sddr09.c                |   1 +
 drivers/usb/storage/sddr55.c                |   1 +
 drivers/usb/storage/shuttle_usbat.c         |   1 +
 drivers/usb/storage/uas.c                   |   1 +
 include/asm-generic/export.h                |  14 +-
 include/linux/export.h                      |  92 +++++++++++--
 include/linux/module.h                      |   2 +
 init/Kconfig                                |  14 ++
 kernel/module.c                             |  67 ++++++++-
 scripts/Makefile.modpost                    |   4 +-
 scripts/coccinelle/misc/add_namespace.cocci |  23 ++++
 scripts/mod/modpost.c                       | 144 ++++++++++++++++++--
 scripts/mod/modpost.h                       |   9 ++
 scripts/nsdeps                              |  54 ++++++++
 30 files changed, 421 insertions(+), 40 deletions(-)
 create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
 create mode 100644 scripts/nsdeps

-- 
2.23.0.rc1.153.gdeed80330f-goog

