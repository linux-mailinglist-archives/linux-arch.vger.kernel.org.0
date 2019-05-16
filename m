Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1152104E
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfEPVxq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 17:53:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38288 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbfEPVxq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 17:53:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 89A8F8EE109;
        Thu, 16 May 2019 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1558043625;
        bh=jjQxK8gG30fC8ztphEl/+NchX6EWOkygL8i2PMuVq9U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ej9cKsPYRiVs3hKWegxKZYbVTyWhjFJDipWtVAXw++pT/OjiGnooSR170YcM1C3Iz
         irU3Cw8B+qD/zqpfXRluw303d1dzUV6uSi3lTX61vTQE6bXvJQPFT2Tle/T2YDMksF
         mqPFgSEU19WymQeFDf8Ozh3PxPh0zTcNc03cylqg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mfCEGp6lPT57; Thu, 16 May 2019 14:53:45 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D48728EE062;
        Thu, 16 May 2019 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1558043625;
        bh=jjQxK8gG30fC8ztphEl/+NchX6EWOkygL8i2PMuVq9U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ej9cKsPYRiVs3hKWegxKZYbVTyWhjFJDipWtVAXw++pT/OjiGnooSR170YcM1C3Iz
         irU3Cw8B+qD/zqpfXRluw303d1dzUV6uSi3lTX61vTQE6bXvJQPFT2Tle/T2YDMksF
         mqPFgSEU19WymQeFDf8Ozh3PxPh0zTcNc03cylqg=
Message-ID: <1558043623.29359.44.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Date:   Thu, 16 May 2019 14:53:43 -0700
In-Reply-To: <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
         <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
         <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
         <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-05-16 at 13:59 -0700, Linus Torvalds wrote:
> On Thu, May 16, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > 
> > I have reconfigured it locally now and pushed an identical tag with
> > a
> > new signature. Can you see if that gives you the same warning if
> > you
> > try to pull that?
> 
> No, same issue:

The problem seems to be this:

jejb@jarvis:~> gpg --list-keys 60AB47FFC9095227
pub   rsa4096 2011-10-27 [C]
      88AFCD206B1611957187F16B60AB47FFC9095227
sub   rsa4096 2011-10-27 [E]

Your key is a "Certification key" and you have an encryption subkey but
no signing key at all.  Usually you either have a signing subkey or
your master key is both certification and signing ([CS] flags). 
Certification keys can only be used to certify other keys, they can't
be used for signing, but I bet gpg is assuming that it can sign with
the master key even if it doesn't possess the signing flag.

You can make your master key a signing key by doing

gpg --expert --edit-key 60AB47FFC9095227

Then doing

gpg> change-usage

and selecting "toggle sign"

Or you could just add a signing subkey.

In either case you'll need to save and sign the changes and then push
to a keyserver for the rest of us to see it.

James

