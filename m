Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C132D210B9
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2019 00:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEPWvN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 18:51:13 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38382 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPWvN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 18:51:13 -0400
Received: by mail-lj1-f181.google.com with SMTP id 14so4574376ljj.5
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68ArjN0wa3lf1aOiRDVUTIQK5CrzgPXu4Jev+44ZCaU=;
        b=ZkmbJ6jP3obgZQ3rn0M9QXzzM0MDNkkO2SFtqSHyLYEk5pVSWq2QI4Rb39tCRjJ/Fc
         K4gBKQT45ncSY/sNglMvHT1MI2FqYxbfh2UWo26BC0aGzbF+0Go0S2rvvamSS7QLfU7w
         wEpr6052AXt0NMlwwtDFDzu7rFOrNcLcKznj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68ArjN0wa3lf1aOiRDVUTIQK5CrzgPXu4Jev+44ZCaU=;
        b=SW4C/lzyEVdbtfxn6USiqNPCU/ynzYROd1MsL3IL9Lo3+J5wR232Nvxh/Q4C8MTeg3
         Ba4PNyHXozf/ufv83VnWU8aCKNMsV5PlWTfkg21bsbHvOxjEZHR8JRBTa76p3hgJaAyW
         H1DpBXrOgKdrFZUgNrY6RDWCMlVUl4I5Kl2iRlGySVOKEzNZYJqOHHY3T3rOF94sH4vr
         BQSYoYcVtJz6e8qT9ruPSLmcXIjz39jjREsr6y4rDV8dccheYruLE8wQiH1QHum1vptA
         8+hD39xWN8xmiWOYyBnSEqMeoqdmHz5j2568z/JCgx1GnvWPDN62Rew96JC18PoJ/dO4
         OzUg==
X-Gm-Message-State: APjAAAXFG1CQL+FOCTJkYCPfG09n0s63DLfGu6F20qJYAHyHRUewM2Nl
        Jd0m3k0pBETBJBDyB40/w85eeSFLUjM=
X-Google-Smtp-Source: APXvYqxhiCzmHGSxoJvzdP+QGrS+piE6zQsr7y6RdVCW+1oW8Or6nq/GWtx/jV351fZ75P29YxsfnQ==
X-Received: by 2002:a2e:7f12:: with SMTP id a18mr1906411ljd.144.1558047071774;
        Thu, 16 May 2019 15:51:11 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u3sm1186611lfc.73.2019.05.16.15.51.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 15:51:11 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c17so3908449lfi.2
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 15:51:10 -0700 (PDT)
X-Received: by 2002:ac2:59c7:: with SMTP id x7mr21576802lfn.75.1558047070605;
 Thu, 16 May 2019 15:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
 <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
 <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
 <1558043623.29359.44.camel@HansenPartnership.com> <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
In-Reply-To: <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 15:50:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+CyMkQJahExx0FNtJf+cd9VqjWNx3z6Em_xW11ScViw@mail.gmail.com>
Message-ID: <CAHk-=wi+CyMkQJahExx0FNtJf+cd9VqjWNx3z6Em_xW11ScViw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 16, 2019 at 3:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Strangely, the copy I have on my local machine does have the 'S'
> flag. I sent it back to the server now.

Yup, now when I refreshed your key, I got an update, and your
signature looks all good.

              Linus
