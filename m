Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7525877
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2019 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfEUTtp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 May 2019 15:49:45 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39976 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfEUTto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 May 2019 15:49:44 -0400
Received: by mail-lj1-f180.google.com with SMTP id q62so7493232ljq.7
        for <linux-arch@vger.kernel.org>; Tue, 21 May 2019 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbAeX3ULgAw+48diKoVE4ufJ3FnxC/sO5bPiY1VSwg8=;
        b=E+UYvhcXOQje8KyA+0nTfTI82/b4+Lq8UVwM13n9yGNLe15UMzG3NRe3XVXlxMmX+F
         /cjPdhV25Qyg9L7P90WLjoq2WReCfOgQK/AouRPXUOpPxsAk5RSXRQQGaiHvef/++IIv
         PUdDHUh5Plvk1f2CC0dmA8AzYpOjX9R4b/Ag4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbAeX3ULgAw+48diKoVE4ufJ3FnxC/sO5bPiY1VSwg8=;
        b=bBOVb442HvMMVXHYNQRsz8TAy52IGmYhLpgWlCM8dmt3mgnUsT8agqygHWE3jZQU28
         NiaMTID6v6azCqVJ5ZpggA+J1LLy05Lqbga00hq4LU9YGyvtv1My0tM9oVSXaD940fun
         OmU56epFCPl/7/SkKUyDG0eKjvCUDjeCi+lygJWWWkMhlzNWOsyh88z/2Uocd31iLguI
         X10HnoAZhaG6XzUO1hTEqbN30rsLlwuQqeFCvSBDu/nzw5rKbm9htdnCxxUg7W1psXI7
         A7sBPxWPk6fmwqtdYiAnfzscejz/V+Wj3Jd55qi4CqZq0ZsmRxBbvTz5vKrz3yn+wOqf
         wUjw==
X-Gm-Message-State: APjAAAUkMxwi6wOqrOcsz/93xqWTBdC2XLIOFz3T+xRniRWd8h51JCuE
        Vv+R20Qav7ck8c1XTBe/JR8lBCY2d2k=
X-Google-Smtp-Source: APXvYqxt/sgE97vPLxcvPR35ITw4ToyIbMuMNLB8lMs+xEW+Bbhgf0KYrbsXwM8oGFq052wKXd5Nrg==
X-Received: by 2002:a2e:80d5:: with SMTP id r21mr30937351ljg.43.1558468182398;
        Tue, 21 May 2019 12:49:42 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 29sm4905994lja.35.2019.05.21.12.49.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:49:41 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q62so7493157ljq.7
        for <linux-arch@vger.kernel.org>; Tue, 21 May 2019 12:49:41 -0700 (PDT)
X-Received: by 2002:a2e:6c0b:: with SMTP id h11mr7174324ljc.15.1558468181175;
 Tue, 21 May 2019 12:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190521162350.GA17107@osiris>
In-Reply-To: <20190521162350.GA17107@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 May 2019 12:49:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCtFPj_Uo1RMHnCLHut8SRG_t5M-E8Uw2+OFmc=c=H6w@mail.gmail.com>
Message-ID: <CAHk-=wgCtFPj_Uo1RMHnCLHut8SRG_t5M-E8Uw2+OFmc=c=H6w@mail.gmail.com>
Subject: Re: Sad News - Martin Schwidefsky
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 21, 2019 at 9:24 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> We are devastated by the tragic death of Martin Schwidefsky who died
> in an accident last Saturday.

Ouch.

Thanks for letting people know, and condolences to friends and family.

               Linus
