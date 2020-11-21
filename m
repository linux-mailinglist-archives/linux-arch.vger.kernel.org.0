Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B5F2BBDA2
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 08:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgKUHAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Nov 2020 02:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgKUHAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Nov 2020 02:00:43 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C29C061A4B
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 23:00:42 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u19so16650079lfr.7
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 23:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qSt/XnTloXSnWYtWCxId4OBXpP28x7HyJlEM0VTTxfw=;
        b=SXMdW3IqDbJ6iWw8IZ9Q5CNHq9VhrWbVp/EFAUzmCzAPgt7dcdixohikYsRS8jBWb1
         kjZbjAisDfdp9lwbGwx8t8ITuW2ZvTjirm7OuW6PzkBN++x9KgW/YZWIVfeW6e6mlx3U
         /lumB7FQ98t3ujt+mefcDxCxr8UBoHSfT7/x/vIP0AqU4k0hMZAjxoIG9CjXFXs8CFQQ
         HZdfjKvCNoGFCrGQCY8jcCvrkzlnJsbl7lsY/u+ZRYaynCCRUhJ+Qr2rZkAfpo8ZBl7g
         IhCZE31GiyxOfhCWdnhAONlyo2d8Cy1QH+CApFXoypZopMLIK39U9YnN+CMIrVgDo1yp
         gxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qSt/XnTloXSnWYtWCxId4OBXpP28x7HyJlEM0VTTxfw=;
        b=iw/xr6prttutBuTeFq/KJ/sDlMtpUN0f2S/fUBxTqfZWxOjX5tNL0WczY3uLruh+5z
         Uk+7497c4KoWWOnMrukxw/6DyXv2bSEZCAKuGIRL6HPqOpg2q8UQwzZbIeFg9NOrfGeV
         RHpeg0X+FT9O/BCeTHu/+QrTEpJMlR56eOYumXe0+ZRmmgkhX+cKtpiLn5uPftZgULEm
         vJcVRAyKc4tReA6QFeqqAdifBSmxcVCEf9JuuZRxU5MFXyDbi8ZT2dOxeZPh2dU84A8s
         /7mqLf5ilR/Jro/ek7iAH6A4AdE8Ygl9hGSTPeFPRSWYDK0mlcJ1Z2GMPoOA3yZo+ted
         kVOA==
X-Gm-Message-State: AOAM531mrNtw6I8jIRjjGwww1vk7Zhs4suyq+LenGYIOy6HxWtglnVs3
        f8A6YVi2zXPuujRN25YoHjwUrg6I7dx8UIfmSv2BXw==
X-Google-Smtp-Source: ABdhPJysESVBpzmb8AIe4IsYMGTwUSB/SEEqglyDLyhegKtUN1uX2v4ambD1WjsgatbnwE0AiCnynPiP1Rb9iZe/YZ0=
X-Received: by 2002:a05:6512:348e:: with SMTP id v14mr8698488lfr.97.1605942041000;
 Fri, 20 Nov 2020 23:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-13-mic@digikod.net>
In-Reply-To: <20201112205141.775752-13-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 08:00:00 +0100
Message-ID: <CAG48ez0S1_jd0YzXZ9tx94gU0sw-WeXgG336d=3YP7+iZvRgaA@mail.gmail.com>
Subject: Re: [PATCH v24 12/12] landlock: Add user and kernel documentation
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 12, 2020 at 9:52 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> This documentation can be built with the Sphinx framework.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>

Reviewed-by: Jann Horn <jannh@google.com>
