Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431493C042
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 02:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfFKACN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 20:02:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390647AbfFKACN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 20:02:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so4282791plr.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2019 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=A82/ddxx3F+ATI2rZx3wBjeD0ledFHTBqnLAZuECLx4=;
        b=KUSlqCLfKiAiQnRELAl1ZV0yc0U5pUCd2gUMULJ3+ELMQm4Hla5QTfxrOBk5YUAEyu
         zW+4qpHpO2pgrjwgBMY+GyzEKHtIpxIVIplITWILvwph3AhY3ZYZWBenMnOPLdgHgItc
         NASjKKHiq2Hn0b+lJstWbgAFaxZx+Q19bWrYD0MV/lo569q87MTUIUBTXXTdPUk5YO6X
         xX1aqotPQG/nM1VygMeR6ruhR81K6olk429urDbudQJ8MQFwV4AvFmmENPQSNEANXtPI
         rjLcJiMHLk1wWtRIhQGnKvHy69UpH1crAMAFqgxmbLBgi7aTQybSq/PyiQyATqDXbiNT
         5WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=A82/ddxx3F+ATI2rZx3wBjeD0ledFHTBqnLAZuECLx4=;
        b=d/iCKuu9FZzO4MYqv3GoODr0jv4JxJ7CZ7DmLIFc1xmYtZoI/oIc+nkG0A6uOFQDRj
         neq7KYefIYwVLZas0opTo27ycr0uUV6jEy7eq0Wa7JvW64o27dJyVjdvYSaWwIMcMoxp
         ovcQngXTIItbmFcubC9How9h5sBJJFoZ3f+Jz13BvUYYnx0FWdr4scuXF9hl0AKS4j3U
         qiTdxCK+rQx4SpjlZD2IIURasnja5aoCW4ETP+m/Djc2NAJwAE0d6peeF2sytayS/Ir3
         U58J4U3QY6q/2fQSoBgPMlFBXsoCu6XmrkyLc16mA6viNmQ1kqoWbKxLBcGnyM6arf2D
         vLeQ==
X-Gm-Message-State: APjAAAWjJ57V+MEMI2/kDgmIFquZviNMaFnqXhEgM6RiV0FZQRmvdRLw
        ZtrPdOM4RjLeBSvYtpMv+5LISQ==
X-Google-Smtp-Source: APXvYqwMeZAM5HN0tbtrDv+73zByg9xRCVQtCgh3nPGiZ8vukjVY4hHdmPlqsE6Qi2SoTZcEbcYFYw==
X-Received: by 2002:a17:902:4181:: with SMTP id f1mr70400039pld.22.1560211332156;
        Mon, 10 Jun 2019 17:02:12 -0700 (PDT)
Received: from ?IPv6:2600:1010:b04b:ab5e:d9b1:bcf9:898:128e? ([2600:1010:b04b:ab5e:d9b1:bcf9:898:128e])
        by smtp.gmail.com with ESMTPSA id a18sm579563pjq.0.2019.06.10.17.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 17:02:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
Date:   Mon, 10 Jun 2019 16:54:52 -0700
Message-Id: <BBBF82D3-EE21-49E1-92A4-713C7729E6AD@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net> <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
 <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net> <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
 <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net> <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
 <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com> <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
 <0665416d-9999-b394-df17-f2a5e1408130@intel.com> <5c8727dde9653402eea97bfdd030c479d1e8dd99.camel@intel.com>
 <ac9a20a6-170a-694e-beeb-605a17195034@intel.com> <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
 <92e56b28-0cd4-e3f4-867b-639d9b98b86c@intel.com> <1b961c71d30e31ecb22da2c5401b1a81cb802d86.camel@intel.com>
 <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
In-Reply-To: <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (16F203)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 10, 2019, at 3:59 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 6/10/19 3:40 PM, Yu-cheng Yu wrote:
>> Ok, we will go back to do_mmap() with MAP_PRIVATE, MAP_NORESERVE and
>> VM_DONTDUMP.  The bitmap will cover only 48-bit address space.
>=20
> Could you make sure to discuss the downsides of only doing a 48-bit
> address space?
>=20
> What are the reasons behind and implications of VM_DONTDUMP?
>=20
>> We then create PR_MARK_CODE_AS_LEGACY.  The kernel will set the bitmap, b=
ut it
>> is going to be slow.
>=20
> Slow compared to what?  We're effectively adding one (quick) system call
> to a path that, today, has at *least* half a dozen syscalls and probably
> a bunch of page faults.  Heck, we can probably avoid the actual page
> fault to populate the bitmap if we're careful.  That alone would put a
> syscall on equal footing with any other approach.  If the bit setting
> crossed a page boundary it would probably win.
>=20
>> Perhaps we still let the app fill the bitmap?
>=20
> I think I'd want to see some performance data on it first.

Trying to summarize:

If we manage the whole thing in user space, we are basically committing to o=
nly covering 48 bits =E2=80=94 otherwise the whole model falls apart in quit=
e a few ways. We gain some simplicity in the kernel.

If we do it in the kernel, we still have to decide how much address space to=
 cover. We get to play games like allocating the bitmap above 2^48, but then=
 we might have CRIU issues if we migrate to a system with fewer BA bits.

I doubt that the performance matters much one way or another. I just don=E2=80=
=99t expect any of this to be a bottleneck.

Another benefit of kernel management: we could plausibly auto-clear the bits=
 corresponding to munmapped regions. Is this worth it?

And a maybe-silly benefit: if we manage it in the kernel, we could optimize t=
he inevitable case where the bitmap contains pages that are all ones :). If i=
t=E2=80=99s in userspace, KSM could do the, but that will be inefficient at b=
est.=
