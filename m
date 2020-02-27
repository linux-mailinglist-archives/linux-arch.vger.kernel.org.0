Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272481723FD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 17:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgB0QwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 11:52:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39081 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgB0QwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 11:52:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id r16so2322684oie.6
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gp52pRjsJhSA+Hsa491NiMGo7ZzN8vh48sP/xPZjY7A=;
        b=h2ckek+46BKub8OVUhke3FC/nXyQRCv+YQ5y9CV5RbavgOyX2emB9a6/jb7odtCAKM
         5ltcv6eQIF7Ic86LAqy26c5McXL14zfj7SHokiEMytQXVSGvnJlTtIuSNHkSOQkFWjRP
         Mu7gYWpvSfwVaBUOsaWiRTp0YvOLWDionRgvz1JkZwXSBMY3V3b96qCMcMlj0mUxU56T
         mo9uGvza0log5cdDTTy2ztxkZVwF2Oog57jDbqdSKdT3X6QIagU/KCEypSCKV9XaPvzj
         wCtt3eoq7JH1jvdYAAnC4fMTn7+3EHxTnrbfi6sRJvcEaM84OCdYDwSLRgwprggtt3Y2
         wEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gp52pRjsJhSA+Hsa491NiMGo7ZzN8vh48sP/xPZjY7A=;
        b=H4MBrBJrkBYcjHwyEfVrhXlTTGRtCDtWr31Eu5hu0QnJcSYD6G9lZt4q+ylnQKJBNZ
         k8sMzR2ypvR9dI6am4miMo9/zWaSl5RA0I24e0zlghK15eL/gU4gBe/qxcLud6cI/DPF
         GqKsic9xuNU2tPlnXS1KJYAtszMd1ZsCvQ8sdqrXPIfC0/V4zhEIQIuJ5wdFeabwEGlo
         nNQ8ArJYOXsA3IzzENv+Bh5ICr63aF3WHnhzPXLd223JPq9p4+Dn5jMYVwEZ3n70Jtam
         rmWvVQ74rGcB8Ow/FJ93dus+S3GNtsM2ei0yBUcmZnm1hdwXxCg6Laqme2Fz5FWlZgBn
         MN1A==
X-Gm-Message-State: APjAAAVUaKqEJxu+u3jUMHEbo10mCdO1YffjjHYnPMeZ/D881wsJLPwI
        VGa3y1xgKWcQ0pXvHLgOeSVOpSGyTA7qXJE3CvCXdQ==
X-Google-Smtp-Source: APXvYqwtYAjsjMZBmazOMBlU4tgSOoeRD3FzHInhjMiQQq9Hs9Q8FYDFJIJz944uJE8l8reZMl0eKMk+IJoxnZLWgp0=
X-Received: by 2002:aca:d954:: with SMTP id q81mr4104431oig.157.1582822337290;
 Thu, 27 Feb 2020 08:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <20200224160215.4136-6-mic@digikod.net>
 <CAG48ez36SMrPPgsj0omcVukRLwOzBzqWOQjuGCmmmrmsGiNukw@mail.gmail.com> <34319b76-44bd-8915-fd7c-5147f901615e@digikod.net>
In-Reply-To: <34319b76-44bd-8915-fd7c-5147f901615e@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Feb 2020 17:51:51 +0100
Message-ID: <CAG48ez1ETFhAZE1A9x=zB=b+t=pFYp3Yc0j8psFQhGwFRdDu2A@mail.gmail.com>
Subject: Re: [RFC PATCH v14 05/10] fs,landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 27, 2020 at 5:50 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> On 26/02/2020 21:29, Jann Horn wrote:
> > On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> >> +static inline u32 get_mem_access(unsigned long prot, bool private)
> >> +{
> >> +       u32 access =3D LANDLOCK_ACCESS_FS_MAP;
> >> +
> >> +       /* Private mapping do not write to files. */
> >> +       if (!private && (prot & PROT_WRITE))
> >> +               access |=3D LANDLOCK_ACCESS_FS_WRITE;
> >> +       if (prot & PROT_READ)
> >> +               access |=3D LANDLOCK_ACCESS_FS_READ;
> >> +       if (prot & PROT_EXEC)
> >> +               access |=3D LANDLOCK_ACCESS_FS_EXECUTE;
> >> +       return access;
> >> +}
[...]
> However, I'm not sure this hook is useful for now. Indeed, the process
> still need to have a file descriptor open with the right accesses.

Yeah, agreed.
