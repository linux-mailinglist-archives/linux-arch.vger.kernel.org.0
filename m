Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB43C0BF
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbfFKA6u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 20:58:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41472 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390229AbfFKA6u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 20:58:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id s24so4315725plr.8
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2019 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Qm0kPO1uAJ3z1V1j+us2fMRdl6WcfjHPQXtYwKhWHOw=;
        b=BVKkouMqizWMIp86sUnwYUIJSyRkM2G6Pe8zlryowrNTb9LFpBf1If0yNMMHqWfp0F
         aqvarMEwPlbihNns5+AGPXDpt1we54kMWHty1e5OgyiGDIetI6BtOAAyQFCAS3LvpXtt
         uzvSXO7fOA1xexLVdCqI1QOPZpKtT4lZVG077v5++zFnzHYcC3ZBSAwwFeHo9MexBqAQ
         2Hhjnsrz/HjTu2HPnoa50Wg160y84xDJPkQyFDks7AOcPsvsPIeb4DvMn/Muc/w88IXq
         lpM8C4dM7VF7To/MMIkC6rQztkpMZWTvQCV7twCTJ1I4ecG5LMDnzxqJ26KNPiGwgDTp
         +SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Qm0kPO1uAJ3z1V1j+us2fMRdl6WcfjHPQXtYwKhWHOw=;
        b=MvVinHEmpm/PpjSLgOS/+LdSqJbLFYrIAup8gFGJWzQY6pz0kWTuDbKzTRo91zmRn/
         zxAQQyA7oeNgJaP6TB+VxpjTE6J5YWZ6Q8s/gbVF19u+MyH4+3OvisT+dvi+2Crr4EcE
         I1bRybU/zpjMLy51LQ5CtfjpbeL7FDI+6SbXjWptV/DAAeUbbnvGN1Wu5xg7sB+uG751
         EQSFpy9DoqCTGnIVp+QxTFuamJM/erGFdmNdvnrrJ2tgUCwlISA67eoBJ0asD6Fy2UvR
         2OgJI56LLwPP/FrKi99qqhleUzhYJGhajB9Yafu2+UDtl0elucZwXLiXHucegWRo2Ckw
         Y5xA==
X-Gm-Message-State: APjAAAUwt+lmWDO59HwDJ5o4r97k3AuKHv+v5fd9UDaKbDFbZFgojPUk
        UU+p/J51yJJ2YBjnZk7842YX+A==
X-Google-Smtp-Source: APXvYqxSKP4PBZdAqAyV8bIxzJS6jMTPwYPb+xhoAjdP1xT8Us29SP9WDn8Ct0Ow9eVbUjBD+yr4Ew==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89mr70909928pld.271.1560214729538;
        Mon, 10 Jun 2019 17:58:49 -0700 (PDT)
Received: from [10.228.61.2] (151.sub-97-41-129.myvzw.com. [97.41.129.151])
        by smtp.gmail.com with ESMTPSA id h19sm11894263pfn.79.2019.06.10.17.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 17:58:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
Date:   Mon, 10 Jun 2019 17:36:03 -0700
Message-Id: <7E931FED-B39D-4C05-8B78-D8CF2F0EF9FC@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net> <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
 <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net> <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
 <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net> <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
 <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com> <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
 <0665416d-9999-b394-df17-f2a5e1408130@intel.com> <5c8727dde9653402eea97bfdd030c479d1e8dd99.camel@intel.com>
 <ac9a20a6-170a-694e-beeb-605a17195034@intel.com> <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
 <92e56b28-0cd4-e3f4-867b-639d9b98b86c@intel.com> <1b961c71d30e31ecb22da2c5401b1a81cb802d86.camel@intel.com>
 <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com> <BBBF82D3-EE21-49E1-92A4-713C7729E6AD@amacapital.net>
 <a329c4fa-adb0-09a4-7a8c-465f82e0e6c7@intel.com>
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
In-Reply-To: <a329c4fa-adb0-09a4-7a8c-465f82e0e6c7@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (16F203)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jun 10, 2019, at 5:08 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 6/10/19 4:54 PM, Andy Lutomirski wrote:
>> Another benefit of kernel management: we could plausibly auto-clear
>> the bits corresponding to munmapped regions. Is this worth it?
>=20
> I did it for MPX.  I think I even went to the trouble of zapping the
> whole pages that got unused.
>=20
> But, MPX tables took 80% of the address space, worst-case.  This takes
> 0.003% :)  The only case it would really matter would be a task was
> long-running, used legacy executables/JITs, and was mapping/unmapping
> text all over the address space.  That seems rather unlikely.

Every wasted page still costs 4K plus page table overhead.  The worst case i=
s a JIT that doesn=E2=80=99t clean up and leaks legacy bitmap memory all ove=
r. We can blame the JIT, but the actual attribution could be complicated.

It also matters when you unmap one thing, map something else, and are sad wh=
en the legacy bits are still set.

Admittedly, it=E2=80=99s a bit hard to imagine the exploit that takes advant=
age of this.=
