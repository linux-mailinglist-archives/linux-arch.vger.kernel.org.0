Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9133228AD0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 23:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgGUVRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbgGUVRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:17:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D1C0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:17:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so198464ljj.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yHNt87DNg06st5Xvcn/k5gkCvt7pppBHpC/nXo6E+w=;
        b=eoUGsPTaLCi+OvvgDt1WVz1j91QiOdJd4Oq2XThqlHQuBV2m/mmlOa1jj8LR6xjFci
         eYqT7+fgO3LWo4uXASHbEhi+l8B4qwpGiW5Q0l23MVEVF02we1Ji9ygGjb3FLO+FP1Mj
         t/a+zOg0W3Se1DdWUn92n1LdvJUR2fKNauo4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yHNt87DNg06st5Xvcn/k5gkCvt7pppBHpC/nXo6E+w=;
        b=geOph6Yx9F49gLavNda0M6oOKpjLjq5QryPNXniMRObrw3Ftk1VB0jqdI8Rwxct0mt
         G3szqvPajj00I+Hor+trDuOvMG5gLn4FEcyVhkuQzg6cscqwSuTXwaENwDwiXb4d3zvw
         fynfmubf9VCnNSPq6y+Nnx6XHzw7EP5PlLD6DqzKTMBpmx35sYEwr4MyX81VaBSnrZgI
         cyWuSQDDrhMXcUGY5yyh+SxRYrixdKcuVfpoVMOmERxCKUJxEWQ1wVmaMl5h81TPoDIu
         dGkSSepaNl/Za1lRIuhzswoWEZPWjvhYeHTql5QFH7mXjZ+4JLW2M81UObn09LMGN39s
         w7WQ==
X-Gm-Message-State: AOAM533rg0Usg2LhGpd45lrj0m5Ku685lJCYqqPDlUeCoskF31K9oGdn
        J0uvu+MJUKJ988yj1ELdQb4fzyNqHH8=
X-Google-Smtp-Source: ABdhPJzaojzuSXHzfFqQPXpSUNAul9JOaupexshKhHKiTPVLW+TEMMxcn/iYknEyPcGC6L5TEBsybQ==
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr12645045ljl.250.1595366229755;
        Tue, 21 Jul 2020 14:17:09 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o1sm5082367ljj.82.2020.07.21.14.17.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:17:08 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id k13so134537lfo.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:17:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr5445624lfr.142.1595366227470;
 Tue, 21 Jul 2020 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
 <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com> <20200721211118.GB2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200721211118.GB2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 14:16:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh59vJmaH_jWWxpr97XdQfUpOTJgMEA11qzvMwJFjB0VQ@mail.gmail.com>
Message-ID: <CAHk-=wh59vJmaH_jWWxpr97XdQfUpOTJgMEA11qzvMwJFjB0VQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 2:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > > But I didn't check. Maybe we don't have anything that stupid in the kernel.
>
> I did.

So then the commit message really should have said so, I feel. That
would have avoided the whole worry, and made it clear that it's not an
issue.

                Linus
