Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE93772BB97
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjFLJDi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 05:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLJC1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 05:02:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7219AB
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 01:59:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id af79cd13be357-75ec6ae7ffaso310115385a.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686560367; x=1689152367;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udMb5vmbnzKeYF+uhRJyDPkoUsUtpYvMhzpQU9v4Emw=;
        b=VBPd4R/l7owkryOiqKleS18B7QN/h7sMestTsfq19/fQKe41wLAHs0M28XjG58+gWY
         /QhySNjh+cwBQsi2JYl3kfH2yj6pIsEg/gNtI7tYB2kPo2ghxyXogYLMSzBYg7h6mHKq
         lps6YFtoralS3pXHYTBAREIrmMOhMED5d8kHIRRNeM+HVm0dfT3x23mV+0AbygYIzRDS
         RbEzS6ozc1aS1vxqF0xgUo1fKmdHk9+C3P7sRqUhApie9a3aZXx1UQGhfxM4KTK47lS9
         ZcQ8NxhUzd4xbmuyfM+F4ohP9Af8GufF5TYgcSHYj1Sp3H+CzLe5b7PsrVA8X32BWwtM
         M2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560367; x=1689152367;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udMb5vmbnzKeYF+uhRJyDPkoUsUtpYvMhzpQU9v4Emw=;
        b=T/Cal7QThhrLJ8nwu4PpzJ3Ar0adhpSXq4+J1h5Ayuv+t1OildYxcxpejyydMIPyi6
         ARLL6eZSom5416hrebwhrKHHl/D8L8eEEG3fTa3TV2H+z/vfEOspOZC1M0jClX+ghtxD
         hjxkW2D96ZLd7gTMYDZtkMMlFZ3XjOUTjKjFBQP0ynVYxoQNSkn5i2QEUyO76X83mkc5
         MZM5G1B2inDa8LYQIqOHGr0q8dAyQAiKzMLg3q/xqprd0SKSqDPnkQ/g114A9cz/rup+
         gyCsShr1x228F+om6LcGFn2wyBvLr89zwjNKGctfDarRPQwfbomNd25v8ny37laVKXA4
         CuvA==
X-Gm-Message-State: AC+VfDwSTU0Yn2TBljtcy4dE3qDSn8RoevPsQkfDxCEACEbIaR/tGrhG
        1n4A1ahHVwmjXn2ZZ+DeKXWOvmKHADqbPqUSiwk=
X-Google-Smtp-Source: ACHHUZ5yQlmjjZ1Orl7B5mFqvYqADAM/MoutFK6d+W8RE7d7gqY8SB3GtWw8yOpt7fylU8HIzD4WGFRF1zBG7+0dXeQ=
X-Received: by 2002:a05:620a:4309:b0:75e:c8d7:dc68 with SMTP id
 u9-20020a05620a430900b0075ec8d7dc68mr9777207qko.62.1686560367270; Mon, 12 Jun
 2023 01:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:35d4:0:b0:786:6524:cddd with HTTP; Mon, 12 Jun 2023
 01:59:26 -0700 (PDT)
Reply-To: trustfundsloancompany50@gmail.com
From:   Mrs Donna <kasdpaul@gmail.com>
Date:   Mon, 12 Jun 2023 10:59:26 +0200
Message-ID: <CAGu963Ha5b6G6qbKpWUV0L6hczDErhhie3mS9MXX_A=QZ+QRbg@mail.gmail.com>
Subject: Re..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:744 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [trustfundsloancompany50[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kasdpaul[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
LOAN AS FAST AS POSSIBLE WITHIN 2DAYS
,
Do you need an urgent loan at 2%? To pay your bills? if yes contact us
today at: trustfundsloancompany50@gmail.com

FILL BELOW LOAN APPLICATION FORM

Name:
Country:
State:
Phone Number:
Age:
ID Card:
Occupation:
Amount Needed as a Loan:
Duration:

NOTE THAT All Email should be forwarded to:
trustfundsloancompany50@gmail.com
