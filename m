Return-Path: <linux-arch+bounces-15010-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F597C7A3FF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 15:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6D164F08D5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ADE348477;
	Fri, 21 Nov 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkJ2//a4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B43451A3
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735679; cv=none; b=If5f8lSBzEejOxLYWmGssjFVF9je8Lrs0HH4VT4ql63ur/2fyyy94u83Oft7S9fn5RZxPmmzZOMcC0DEHG6MEjigk6r4+cXtq1dxxkwVgcgt8kx98IqRw5qqiqBGWifyQa+QkmxENzPwyhv0hfWvc1mayVvqUDJGtBrgkNmr7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735679; c=relaxed/simple;
	bh=9j817sGSUWyrm/7CiS76bg2pdken9wwE7C4n6AbPYqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAqYFgFupyQNev7FPKvIypnsBvnYEn6S6xYBt4jtDafZkqO9OT/sgoVDWFgdaOXk/kmvMCozpsf5ewYuDio3zk7x6DNZPADPGW2EP9vv93FSlikKfLBnTtyOrkVMFF+LLVRF96vBUtnBrRSxLeEuiXNUjfmh1sYSn31wenyhlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkJ2//a4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee243b98caso241391cf.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 06:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763735675; x=1764340475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKb38sj4hQipqt6kiYCoo6X4XOGCTp8AckomBjnyGVc=;
        b=hkJ2//a4c5F1iJh/9exeaM2h5tFWviDC8TqygLqQs5VDUwEDnbeKhv2hlAn0F9u6OU
         eoGOYK9+kt8aXqNQZSOUD6QfOB2nNmqkvyuNrSjvEqjWiaoGWK0sTPWDAFjS05bL5J1W
         3LE3/MWvszQiOJ+AKcklLmJeZPadllDZgZdAw0HtG7HjMkijLj3TpnYYYfOAGWbV39zi
         1rrnJRr3ziq0PtifUgj3UTlwmOgjIRd1JcrvjWQyxmaSO25RcunWvS0Hnjv1u4XNZlji
         VXEvaaQtp83lA10jIKMZ7LO3ceRv55cQHKSpXMn5cqBcPxHe8YCIuTBMNqp3iozn7i78
         dWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735675; x=1764340475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKb38sj4hQipqt6kiYCoo6X4XOGCTp8AckomBjnyGVc=;
        b=QffWVtzyWqEKSoST6RidNTPtYrCXk9cM/CAmjxA5qQmzm6QyCyDygcqX2+i2hOVjfw
         OZJOFJqJ63+nyi0ornzN0EH5iE82VRo0rYYhsCeGpvz05nt/sfI78S1ayCaqKQ2R21tg
         ZeWU4niG3qkiXFuEr6JzzWhG3P8uVhSjN+zMybHdWGckEMJqidvJkOgW7DkO6L9xVLmo
         GHp0yZP51lTzcNWpPe504hywOW3HS0xnXkkpsbBkQLnPa2kMeyT/fQn0hIuib1vvIJkV
         N9o9GqnReEC+6Au4OBWzRUbpm3D8btzKoqOxJf1aTK5TBLfGpj4K7P99B+SSXg48ReWW
         8PRA==
X-Forwarded-Encrypted: i=1; AJvYcCXmiWazV92TOHoQpoD56Rz/S1nqfTOeauF/Qjvcl2eMwCOnnL2jXdfSl6EHRv8Y5Ah5gJ2WMvGp2eYd@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+DKzVrHqPOzlrPDeRhnZA92CGVdWaoC3FrsU7xubOfXVkNNE
	QJl4nN6zR0qwKt9d+Ge0ZL9ZmW+q9uYPZ1IIs5Hx5kDE7t5bBr/lkBTR0gBC4Ku1cmiO0/ehRrX
	5p6L1Be/XQ0en4gjDYmgPcB578RzISfS1Zh4SBkRt
X-Gm-Gg: ASbGncu4fHHAU1eUx3szCWzYOucL/yMGuJF4osjHZ451GPvx5Np1noW0WAZPGEWV2BG
	eHwgkEIR4m5G+WyfK0pd3YOOm7sWBMNjzowMYNlUVP9YihGAhv7RVUvQpgmbELXvDh7DmPknjjr
	Oh+syy9ozv+pvINq67/ZdS+7joC5jk6QuybjDIjxNr3qZrDJFHyz+IJ02nLmVCFS59tmee5zKkR
	bpDrGMcz0YFm8JniEy0QNXwO8fudpW3JBhAypqxiw9gxBxgXbAgWHKkhdYUzXxxbYvczmM/
X-Google-Smtp-Source: AGHT+IE3tXokxEKbGyVPkRZEhFmWDWFcNY1QcdU/+FkYXPiUYutkaK9TCizIkTCsPnEimKmJ9skmDa2QtdNEnJmmXJ8=
X-Received: by 2002:ac8:57d0:0:b0:4ed:2f7d:bd46 with SMTP id
 d75a77b69052e-4ee5874e6d5mr4248981cf.13.1763735674656; Fri, 21 Nov 2025
 06:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116182839.939139-1-lrizzo@google.com> <20251116182839.939139-4-lrizzo@google.com>
 <87seec78yf.ffs@tglx> <87bjl06yij.ffs@tglx> <CAMOZA0+rA-ys1JSb=GxpPEFS7W8TJGz23gSuUWi0Kv7TX2FfSg@mail.gmail.com>
 <878qg37n8p.ffs@tglx> <CAMOZA0+K73YbPqq_vTS2sMkbV-0Fh5GSCt3ABfReV3DYk1CO2g@mail.gmail.com>
 <87pl9fmhe5.ffs@tglx> <CAMOZA0JXv1ERyGOJ8fmwefnc6XKbGGy-E4p_d+BFr6KPzoOUZw@mail.gmail.com>
 <CAMOZA0Jj=BYXx1QYxFQRbtmFYfZeQBySqDS6n1skHFEYD=1EZQ@mail.gmail.com>
 <877bvmm6b2.ffs@tglx> <CAMOZA0L3+ohfgNfDr50-rcNNnssK0q8Snde8FrWnfn8YcWH=Ew@mail.gmail.com>
In-Reply-To: <CAMOZA0L3+ohfgNfDr50-rcNNnssK0q8Snde8FrWnfn8YcWH=Ew@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 21 Nov 2025 15:33:58 +0100
X-Gm-Features: AWmQ_bn0NQB3RiIqQ3D6zwMn8tP1T6N1_22WDxo1uvP9F368_uOzXOO8qPWdIEI
Message-ID: <CAMOZA0KPPyCFO4XYKhRfrnpMV1CiOkOd0dX41yottKp0p3nYww@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:58=E2=80=AFAM Luigi Rizzo <lrizzo@google.com> wr=
ote:
>
> On Wed, Nov 19, 2025 at 3:43=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> >
> ...
> >
> > ...
> > That said, I'm happy to answer _informed_ questions about semantics,
> > rules and requirements if they are not obvious from the code.

Some followup on the cost of mask_irq()  which is rarely called without
moderation, but is hit hard with moderation:

For msix devices, mask_irq() eventually calls the following function

static inline void pci_msix_mask(struct msi_desc *desc)
{
        desc->pci.msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
        pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl); //
eventually, writel()
        /* Flush write to device */
        readl(desc->pci.mask_base);
}

The final readl() is very expensive (serialized after the write, and takes
a full round trip through a busy PCIe bus). Its real purpose is to make
sure the function returns only after the hardware has seen the mask.

Except for a few critical places (setup/shutdown, others?) it does not
seem necessary to wait, because the irq layer knows how to drop stray
interrupts.

Here is an experiment removing the readl() where it is not critical,
during an experiment with busy NVME workload (~1M intr/s total)
The average goes from 1800ns down to 50ns, the long tails almost
completely disappear.

Data is collected with kstats https://lwn.net/Articles/813303/
Distribution of mask_irq() times in nanoseconds collected with kstats
over a 5s period, heavy workload.

F=3D/sys/kernel/debug/kstats/mask_irq
echo reset > $F; sleep 5; grep CPUS $ | awk '{t+=3D$6*$8;n+=3D$6; print}
END { print "avg ", t/n, t*1e-9}'

-------------------------------------------------------
ORIGINAL CODE

count      945  avg      680  p 0.000195  n      945
count     1863  avg      742  p 0.000580  n     2808
count     2941  avg      805  p 0.001188  n     5749
count     6058  avg      866  p 0.002441  n    11807
count    10090  avg      930  p 0.004527  n    21897
count    17273  avg      994  p 0.008099  n    39170
count    88252  avg     1099  p 0.026348  n   127422
count   227984  avg     1223  p 0.073490  n   355406
count   405964  avg     1348  p 0.157434  n   761370
count   530397  avg     1474  p 0.267109  n  1291767
count   606284  avg     1601  p 0.392475  n  1898051
count   658027  avg     1728  p 0.528541  n  2556078
count   643644  avg     1854  p 0.661632  n  3199722
count   515443  avg     1980  p 0.768215  n  3715165
count   546976  avg     2156  p 0.881317  n  4262141
count   243037  avg     2415  p 0.931572  n  4505178
count   125700  avg     2674  p 0.957564  n  4630878
count    73707  avg     2934  p 0.972805  n  4704585
count    48124  avg     3190  p 0.982756  n  4752709
count    30397  avg     3446  p 0.989041  n  4783106
count    19108  avg     3700  p 0.992993  n  4802214
count    11228  avg     3956  p 0.995314  n  4813442
count    11484  avg     4316  p 0.997689  n  4824926
count     5447  avg     4835  p 0.998815  n  4830373
count     2699  avg     5341  p 0.999373  n  4833072
count     1343  avg     5855  p 0.999651  n  4834415
count      668  avg     6369  p 0.999789  n  4835083
count      382  avg     6880  p 0.999868  n  4835465
count      207  avg     7406  p 0.999911  n  4835672
count      149  avg     7918  p 0.999942  n  4835821
count      159  avg     8671  p 0.999975  n  4835980
count       61  avg     9574  p 0.999987  n  4836041
count       22  avg    10758  p 0.999992  n  4836063
count       15  avg    11925  p 0.999995  n  4836078
count        9  avg    12750  p 0.999997  n  4836087
count        6  avg    13739  p 0.999998  n  4836093
count        2  avg    14737  p 0.999998  n  4836095
count        1  avg    15699  p 0.999999  n  4836096
count        3  avg    17951  p 0.999999  n  4836099
count        1  avg    18680  p 1.000000  n  4836100
avg  1833.11 8.86512

-------------------------------------------------------
AFTER REMOVING READL()

count       45  avg       13  p 0.000009  n       45
count     5792  avg       14  p 0.001204  n     5837
count    36628  avg       15  p 0.008761  n    42465
count   108293  avg       17  p 0.031103  n   150758
count   529586  avg       18  p 0.140365  n   680344
count   352816  avg       21  p 0.213156  n  1033160
count  1082719  avg       22  p 0.436538  n  2115879
count   480375  avg       24  p 0.535646  n  2596254
count   628931  avg       26  p 0.665404  n  3225185
count   275178  avg       28  p 0.722178  n  3500363
count   158508  avg       30  p 0.754880  n  3658871
count   100066  avg       33  p 0.775525  n  3758937
count    42338  avg       38  p 0.784260  n  3801275
count    75427  avg       41  p 0.799822  n  3876702
count    43099  avg       45  p 0.808714  n  3919801
count    30181  avg       49  p 0.814941  n  3949982
count     3757  avg       53  p 0.815716  n  3953739
count     2104  avg       57  p 0.816150  n  3955843
count     3520  avg       62  p 0.816876  n  3959363
count    28199  avg       69  p 0.822694  n  3987562
count    72163  avg       76  p 0.837583  n  4059725
count   109582  avg       83  p 0.860191  n  4169307
count    35839  avg       90  p 0.867585  n  4205146
count     6622  avg      100  p 0.868951  n  4211768
count    19393  avg      109  p 0.872952  n  4231161
count    51844  avg      116  p 0.883649  n  4283005
count    94042  avg      122  p 0.903051  n  4377047
count    28129  avg      133  p 0.908854  n  4405176
count    91010  avg      151  p 0.927631  n  4496186
count    73043  avg      164  p 0.942701  n  4569229
count    20705  avg      185  p 0.946973  n  4589934
count    59477  avg      199  p 0.959244  n  4649411
count    10842  avg      212  p 0.961481  n  4660253
count    16374  avg      233  p 0.964859  n  4676627
count    35394  avg      242  p 0.972161  n  4712021
count    36254  avg      277  p 0.979641  n  4748275
count    16982  avg      304  p 0.983145  n  4765257
count    20411  avg      327  p 0.987356  n  4785668
count    14352  avg      362  p 0.990317  n  4800020
count    10931  avg      399  p 0.992572  n  4810951
count     8384  avg      436  p 0.994302  n  4819335
count     3184  avg      467  p 0.994959  n  4822519
count     4923  avg      487  p 0.995974  n  4827442
count     7341  avg      538  p 0.997489  n  4834783
count     2957  avg      606  p 0.998099  n  4837740
count     3688  avg      666  p 0.998860  n  4841428
count     1807  avg      732  p 0.999233  n  4843235
count      813  avg      800  p 0.999400  n  4844048
count      699  avg      856  p 0.999545  n  4844747
count      293  avg      927  p 0.999605  n  4845040
count      203  avg      985  p 0.999647  n  4845243
count      390  avg     1086  p 0.999727  n  4845633
count      273  avg     1213  p 0.999784  n  4845906
count      162  avg     1336  p 0.999817  n  4846068
count       89  avg     1465  p 0.999835  n  4846157
count       50  avg     1600  p 0.999846  n  4846207
count       33  avg     1727  p 0.999853  n  4846240
count       26  avg     1850  p 0.999858  n  4846266
count       38  avg     1993  p 0.999866  n  4846304
count       89  avg     2185  p 0.999884  n  4846393
count      132  avg     2444  p 0.999911  n  4846525
count      134  avg     2680  p 0.999939  n  4846659
count       92  avg     2932  p 0.999958  n  4846751
count       65  avg     3182  p 0.999971  n  4846816
count       42  avg     3448  p 0.999980  n  4846858
count       29  avg     3713  p 0.999986  n  4846887
count       11  avg     3934  p 0.999988  n  4846898
count       18  avg     4305  p 0.999992  n  4846916
count       10  avg     4784  p 0.999994  n  4846926
count        7  avg     5264  p 0.999996  n  4846933
count        5  avg     5957  p 0.999997  n  4846938
count        1  avg     6603  p 0.999997  n  4846939
count        1  avg     7098  p 0.999997  n  4846940
count        3  avg     7433  p 0.999998  n  4846943
count        1  avg     7892  p 0.999998  n  4846944
count        2  avg     8955  p 0.999998  n  4846946
count        3  avg     9424  p 0.999999  n  4846949
count        1  avg    11194  p 0.999999  n  4846950
count        2  avg    11619  p 1.000000  n  4846952
avg  51.3519 0.2489

-------------------------------------------------------

cheers
Luigi

