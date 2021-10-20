Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9C434B65
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTMoB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 08:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTMoB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 08:44:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24691C06161C
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 05:41:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f11so2843249pfc.12
        for <linux-arch@vger.kernel.org>; Wed, 20 Oct 2021 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Djpr1AS9BhRB0i84aUYk51L5QfT0/KDcZHhY+64EDVg=;
        b=Pe+DfAkkUl3b+BU7BaFKvSYA64GI/P95+xRFPje+Hpd22/CKbh3MC69Y5K0VCm6gKC
         ACzfu0evDZq+Dq1RiQn5s0+zOi3Fv/kEdox5FjGuD7WVHQUSfNRLptOoTmMy5ZHcRyOX
         2ulMjpMvGEGxlBHrEpKxLwkeo4ZWh3Ys7aqUssWYk8qcjhsW+stImHxIrSekQv3XXU/9
         SAudW6g8ap2P5r+1WQnKvcEOXC7tLDV71YEm1UNixjh+/oYnLIQxtjS10N4Pqx0licIV
         le700PEdUEtskmAXcyRF0GB/GkPL7Clo9eZrt1XDOTd7+0GcuavCqsJeFJhcuwZJ8J0K
         5clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Djpr1AS9BhRB0i84aUYk51L5QfT0/KDcZHhY+64EDVg=;
        b=VR6yQTJnCAK17vjaJPZS0GFjNlTdRWZczEwksoYm8KKDTish6/TB+EWxRxq671vMUE
         Spa+Mn/6+PeclQtgTyRNZQUSDutZKJZ/VLKWQ1jiwWWR71xpCS8C52sADajC219XNL3I
         a2m5ZcJ2MAu76Z3lvn3Vc8NbYquukKOB+BU2AU77FLEIN/vgd3nLWRTT+kfIL0iEIi7Z
         daeobCphL0m9R5ZYngqpGH0v4yYLZSZ6Zi3q8CPtw2NV4DUZOMTUTeHghhRkGymlQmuo
         qI/YCPoLHmM15mp/RFxkflNWzCrQjJ1EpotINWZw32alFElIMnm5eBwvSP9N2w22qcn5
         wxUg==
X-Gm-Message-State: AOAM530ouuRqfOyINCe/eAGtzraQfGnOhiKpu9VMxNz4HeyM53Ef3OL8
        ddyjIFuyUD4gRCJuGFHy23g9WAgs7Q+tbtGq/iM=
X-Google-Smtp-Source: ABdhPJyRVL0CUadwI0BEN11Wn1HGjmVhztg12sAJ9YVMPr0tUag1oQzAnwgrPDVl4PDxsgq6KFzw3wdlisrwovEtW7o=
X-Received: by 2002:a05:6a00:731:b0:44c:7c1b:fe6a with SMTP id
 17-20020a056a00073100b0044c7c1bfe6amr6127293pfm.44.1634733706712; Wed, 20 Oct
 2021 05:41:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4f4c:0:0:0:0 with HTTP; Wed, 20 Oct 2021 05:41:46
 -0700 (PDT)
Reply-To: lerynne_west51@zohomail.eu
From:   Lerynne West <wisdomloancompany2@gmail.com>
Date:   Wed, 20 Oct 2021 05:41:46 -0700
Message-ID: <CALARXnGnoTAF4uo7xKOGbqzizq=ad4k-644W0qrw_XNXA5RaZg@mail.gmail.com>
Subject: =?UTF-8?Q?Ich_spende_Ihnen_diesen_Betrag=2C_um_den_von_COVID_19_?=
        =?UTF-8?Q?betroffenen_H=C3=A4usern_zu_helfen?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20




*Beachtung,Sie wurden autorisiert, eine Gesamtspende von 500.000,00 USD aus
dem Covid-19-Unterst=C3=BCtzungsprogramm des Lerynne West Emergency Fund zu
erhalten. Um diese Spende einzufordern, kontaktieren Sie sie mit Ihrer
EMF-ID: COV-0043034. Ihre Spende in H=C3=B6he von 500.000 USD wird Ihnen ge=
m=C3=A4=C3=9F
unserer Richtlinie und Mission innerhalb von 78 Stunden von einer
akkreditierten Gesch=C3=A4ftsbank zugestellt. Siehe den Link unten:*
https://www.youtube.com/watch?v=3DhtEHuyOHUsc

*Antworten Sie mit EMF-ID: (COV-0043034) auf diese E-Mail*:
lerynne_west51@zohomail.eu



*Peggy Rock,CEOEMF-UNTERST=C3=9CTZUNGSPROGRAMM*
