Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7AB56F28
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZQw3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 12:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZQw3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 12:52:29 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4187208E3
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2019 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561567948;
        bh=HRYwpEhWyX7E2FQ6UPIYExmUfpc/Jlx0RSgHf7IrqXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ituj+nZQWO7VbYEj/HDw2ad1/JjMSiA77Jp2vlnVDSdaFemF1iYFuxrmfsPtNmcQo
         z7hBhfGrzvokRliR18OJ9m2CNCeC5ex51F/fox5BJvHxxCVmuTKFl9H9zcfPh4YMsw
         TsidKV+f9OuNcZsVZJrcAS7yJjCI4avQMRFVucRE=
Received: by mail-wr1-f46.google.com with SMTP id p11so3550777wre.7
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2019 09:52:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWnc4Zg1MbRajx5sLUQwUu2GtitrFvVyfUdc/vveWgtM/nLm3P6
        Ah1IY+Mfdg9ubtE1/JSx/m9BkxFd+Z+g6Yi/nqeD/Q==
X-Google-Smtp-Source: APXvYqywRNAoo6NZyWHgZkgrbAhKA3IIUellYWBt2F2/ZGQsVnqn6uUseZihP4BndLtoxsPG+7TR/Yd+9ZAA4JP6fRo=
X-Received: by 2002:adf:a443:: with SMTP id e3mr4277325wra.221.1561567946599;
 Wed, 26 Jun 2019 09:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de>
 <87lfxpy614.fsf@oldenburg2.str.redhat.com> <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
 <87a7e5v1d9.fsf@oldenburg2.str.redhat.com> <CALCETrUDt4v3=FqD+vseGTKTuG=qY+1LwRPrOrU8C7vCVbo=uA@mail.gmail.com>
 <87o92kmtp5.fsf@oldenburg2.str.redhat.com> <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net>
 <87r27gjss3.fsf@oldenburg2.str.redhat.com> <534B9F63-E949-4CF5-ACAC-71381190846F@amacapital.net>
 <87a7e4jr4s.fsf@oldenburg2.str.redhat.com> <6CECE9DE-51AB-4A21-A257-8B85C4C94EB0@amacapital.net>
 <87sgrw1ejv.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87sgrw1ejv.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Jun 2019 09:52:15 -0700
X-Gmail-Original-Message-ID: <CALCETrUG9yHf4D_fDEj054Bgo4zXpmK5UzME9mKNqD70U7vy5Q@mail.gmail.com>
Message-ID: <CALCETrUG9yHf4D_fDEj054Bgo4zXpmK5UzME9mKNqD70U7vy5Q@mail.gmail.com>
Subject: Re: Detecting the availability of VSYSCALL
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Carlos O'Donell" <carlos@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 26, 2019 at 9:45 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Andy Lutomirski:
>
> > Can=E2=80=99t an ELF note be done with some more or less ordinary asm s=
uch
> > that any link editor will insert it correctly?
>
> We've just been over this for the CET enablement.  ELF PT_NOTE parsing
> was rejected there.

No one told me this.  Unless I missed something, the latest kernel
patches still had PT_NOTE parsing.  Can you point me at an
enlightening thread or explain what happened?

> > The problem with a personality flag is that it needs to have some kind
> > of sensible behavior for setuid programs, and getting that right in a
> > way that doesn=E2=80=99t scream =E2=80=9Cexploit me=E2=80=9D while pres=
erving useful
> > compatibility may be tricky.
>
> Are restrictive personality flags still a problem with user namespaces?
> I think it would be fine to restrict this one to CAP_SYS_ADMIN.

We could possibly get away with this, but now we're introducing a
whole new mechanism.  I'd rather just add proper per-namespace
sysctls, but this is a pretty big hammer.
